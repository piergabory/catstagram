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
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure(let error):
                VStack {
                    Image(systemName: "xmark.circle")
                    Text(error.localizedDescription)
                }
            @unknown default:
                VStack {
                    Image(systemName: "xmark.circle")
                    Text("API changed!")
                }
            }
        }
    }
}

#Preview {
    PostImage(url: URL(string: "https://picsum.photos/id/2/400/400")!)
}
