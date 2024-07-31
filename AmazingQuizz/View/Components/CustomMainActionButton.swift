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
    var action: () -> Void
    @State private var isPress: Bool = false
    
    var body: some View {
        Button {
            action()
            isPress.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPress = false
            }
        } label: {
            Text(title)
                .font(.system(.title3, design: .rounded,weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color, in: RoundedRectangle(cornerRadius: .infinity))
                .shadow(radius: 10)
                .scaleEffect(isPress ? 0.5 : 1.0)
                .animation(.bouncy, value: isPress)
        }
    }
}

#Preview("CustomMainActionButton Preview") {
    CustomMainActionButton(title: "My Custom Button !", action: {
        print("Test button")
    })
}
