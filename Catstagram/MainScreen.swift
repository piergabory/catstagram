//
//  MainScreen.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Catstagram")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var content: some View {
        VStack {
            Text("TODO...")
        }
    }
}

#Preview {
    MainScreen()
}
