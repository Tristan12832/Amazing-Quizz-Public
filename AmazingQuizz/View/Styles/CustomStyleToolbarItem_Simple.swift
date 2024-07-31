//
//  CustomStyleToolbarItem_Simple.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 01/04/2024.
//

import SwiftUI

struct CustomStyleToolbarItem_Simple: ButtonStyle {
    @State private var enabled = false
    @State private var scale = 0.0
    var color: Color = .primary
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title, design: .rounded, weight: .heavy))
            .foregroundStyle(color)
            .shadow(radius: configuration.isPressed ? 0 : 8)
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == CustomStyleToolbarItem_Simple {
    static var toolbarItem_Simple: CustomStyleToolbarItem_Simple {
        let color: Color = .accent
        return CustomStyleToolbarItem_Simple(color: color)
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(CustomStyleToolbarItem_Simple())
}
