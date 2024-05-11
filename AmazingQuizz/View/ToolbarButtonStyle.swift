//
//  toolbarButtonStyle.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 11/02/2024.
//

import SwiftUI

struct toolbarButtonStyle: ButtonStyle {
    var color: Color = .accent
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(color)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(toolbarButtonStyle())
}
