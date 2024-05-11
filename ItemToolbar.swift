//
//  ItemToolbar.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/04/2024.
//

import SwiftUI

struct ItemToolbar: ButtonStyle {
    @State private var enabled = false
    @State private var scale = 0.0
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(color)
            .font(.system(.headline, design: .rounded, weight: .bold))
            .clipShape(.capsule(style: .circular))
            .padding(4)
            .background(.black)
            .clipShape(.capsule(style: .circular))
            .padding(4)
            .background(color)
            .foregroundStyle(.black)
            .clipShape(.capsule(style: .circular))
            .shadow(radius: configuration.isPressed ? 0 : 8)
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview("ItemToolbar", traits: .sizeThatFitsLayout) {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(ItemToolbar(color: .white))
}
