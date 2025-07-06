//
//  Carrousel.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct Carousel<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                content
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}
