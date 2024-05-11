//
//  AddButtonStyle.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/02/2024.
//

import Foundation
import SwiftUI

struct PrincipalActionButtonStyle: ButtonStyle {
    var colorText: Color
    var colorBackground: Color
    var font: Font
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .background(colorBackground, in: .capsule)
            .font(font)
            .foregroundStyle(.white)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .foregroundStyle(colorText)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension ButtonStyle where Self == PrincipalActionButtonStyle {
    static var principalActionButton: PrincipalActionButtonStyle {
        let colorText: Color = .primary
        let colorBackground: Color = .accent
        let font: Font = .title2
        
        return PrincipalActionButtonStyle(colorText: colorText, colorBackground: colorBackground, font: font)
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Add new collection", systemImage: "plus")
    }
    .buttonStyle(PrincipalActionButtonStyle(colorText: .white, colorBackground: .accent, font: .title2))
}

struct SecondeActionButtonStyle: ButtonStyle {
    var colorText: Color = .primary
    var colorBackground: Color = .complementary
    var font: Font = .system(size: 20)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .foregroundStyle(colorText)
            .padding(6)
            .background(colorBackground, in: RoundedRectangle(cornerRadius: 16))
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == SecondeActionButtonStyle {
    static var secondeActionButtonStyle: SecondeActionButtonStyle {
        SecondeActionButtonStyle()
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(SecondeActionButtonStyle())
}
