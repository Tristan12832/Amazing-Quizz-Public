//
//  CustomCreatButton.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 04/02/2024.
//

import SwiftUI

struct CustomMainActionButton: View {
    var title: String
    var color: Color = .accent
    var action: () -> ()

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(.title3, design: .rounded,weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                .shadow(radius: 8)
        }
    }
}

#Preview("CustomMainActionButton Preview") {
    CustomMainActionButton(title: "My Custom Button !", action: {
        print("Test button")
    })
}
