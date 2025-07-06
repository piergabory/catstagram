//
//  ImageCache.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI
import os

@Observable
final class ImageCache {
    var cache = OSAllocatedUnfairLock<[URL: Task<Image, Error>]>(initialState: [:])

    @discardableResult
    func fetch(_ url: URL) -> Task<Image, Error> {
        let task = Task {
            let data = try Data(contentsOf: url)
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            } else {
                return Image(systemName: "xcross.circle")
            }
        }
        cache.withLock { cache in
            cache[url] = task
        }
        return task
    }

    func getImage(_ url: URL) async throws -> Image? {
        let task = cache.withLock { cache in
            cache[url]
        }
        return try await task?.value
    }
}

extension View {
    func imageCache() -> some View {
        environment(ImageCache())
    }

    func prefetch(images: [URL]) -> some View {
        modifier(ImageCachePrefetcher(urls: images))
    }
}

struct CachedImage<Content: View>: View {
    private let url: URL
    private let imageModifier: (Image?) -> Content

    @Environment(ImageCache.self)
    private var imageCache: ImageCache

    @State
    private var image: Image?

    init(_ url: URL, @ViewBuilder imageModifier: @escaping (Image?) -> Content) {
        self.url = url
        self.imageModifier = imageModifier
    }

    var body: some View {
        Group {
            if let image {
                imageModifier(image)
            } else {
                ProgressView()
            }
        }
        .task {
            image = try? await imageCache.getImage(url)
        }
    }
}

private struct ImageCachePrefetcher: ViewModifier {
    let urls: [URL]

    @Environment(ImageCache.self)
    private var imageCache: ImageCache

    func body(content: Content) -> some View {
        content
            .task {
                for url in urls {
                    imageCache.fetch(url)
                }
            }
    }
}
