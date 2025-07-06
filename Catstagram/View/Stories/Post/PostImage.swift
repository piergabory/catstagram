//
//  PostImage.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct PostImage: View {
    let url: URL

    var body: some View {
        CachedImage(url) { image in
            if let image {
                image
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    PostImage(url: URL(string: "https://picsum.photos/id/2/400/400")!)
        .imageCache()
}
