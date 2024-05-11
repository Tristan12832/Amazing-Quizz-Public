//
//  NextOrPastButton.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/04/2024.
//

import SwiftUI

struct NextOrPastButton: ButtonStyle {
    @State private var enabled = false
    @State private var scale = 0.0
    var foregroundColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title, design: .rounded, weight: .heavy))
            .padding()
            .foregroundStyle(foregroundColor)
            .shadow(radius: configuration.isPressed ? 0 : 8)
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)

    }
}

#Preview("NextOrPastButton") {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(NextOrPastButton(foregroundColor: .cyan))
}
