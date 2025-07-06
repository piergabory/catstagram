//
//  CubeTransitionModifier.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//


import SwiftUI

extension AnyTransition {
    static var cube: AnyTransition {
        .asymmetric(insertion: .cubeRotateIn, removal: .cubeRotateAway)
        .animation(.linear)
    }

    private static var cubeRotateIn: AnyTransition {
        .modifier(
            active: CubeTransitionModifier(angle: .degrees(90)),
            identity: CubeTransitionModifier(angle: .zero)
        )
    }

    private static var cubeRotateAway: AnyTransition {
        .modifier(
            active: CubeTransitionModifier(angle: .degrees(-90)),
            identity: CubeTransitionModifier(angle: .zero)
        )
    }
}

private struct CubeTransitionModifier: ViewModifier {
    let perspective = 0.5
    let angle: Angle

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .rotation3DEffect(
                    angle,
                    axis: (0, 1, 0),
                    anchor: .center,
                    anchorZ: -proxy.size.width / 2,
                    perspective: perspective
                )
                .scaleEffect(1 - perspective / 4)
        }
    }
}

#Preview {
    @Previewable @State var index: CGFloat = 0

    ZStack {
        Rectangle()
            .opacity(index / 100.0)
            .border(.primary)
            .id(index)
            .transition(.cube)
    }
    .frame(width: 200, height: 400)
    .border(.primary)
    .animation(.default, value: index)
    .task {
        while true {
            index += 10
            try? await ContinuousClock().sleep(for: .seconds(1))
        }
    }
}
