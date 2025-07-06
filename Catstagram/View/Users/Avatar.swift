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
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
            case .empty:
                ProgressView()
            case .failure(let error):
                Image(systemName: "xmark.circle")
                    .onAppear {
                        print(error)
                    }
            @unknown default:
                Image(systemName: "xmark.circle")
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
}
