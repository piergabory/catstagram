//
//  Avatar.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct Avatar: View {
    let url: URL?

    var body: some View {
        Group {
            if let url {
                CachedImage(url) { image in
                    if let image {
                        image.resizable()
                    } else {
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .foregroundStyle(.secondary)
        .clipShape(Circle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Avatar(url: URL(string: "https://i.pravatar.cc/300?u=1"))
        .imageCache()
}
