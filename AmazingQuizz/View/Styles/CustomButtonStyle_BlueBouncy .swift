//
//  CustomButtonStyle_BlueBouncy .swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 02/04/2024.
//

import SwiftUI

struct CustomButtonStyle_BlueBouncy: ButtonStyle {
    @State private var scale = 0.0
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title2, design: .rounded, weight: .bold))
            .padding()
            .background(.complementary)
            .foregroundStyle(.primary)
            .clipShape(.capsule(style: .circular))
            .shadow(radius: configuration.isPressed ? 0 : 8)
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)

    }
}

extension ButtonStyle where Self == CustomButtonStyle_BlueBouncy {
    static var customButtonStyle_BlueBouncy: CustomButtonStyle_BlueBouncy {
        CustomButtonStyle_BlueBouncy()
    }
}

#Preview("CustomButtonStyle_BlueBouncy") {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(CustomButtonStyle_BlueBouncy())
}
