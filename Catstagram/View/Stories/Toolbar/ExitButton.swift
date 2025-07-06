//
//  ExitButton.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct ExitButton: View {
    @Environment(\.dismiss)
    private var dismiss: DismissAction

    var body: some View {
        Button("Close", systemImage: "xmark") {
            dismiss()
        }
        .tint(.primary)
        .labelStyle(.iconOnly)
    }
}

#Preview {
    ExitButton()
}
