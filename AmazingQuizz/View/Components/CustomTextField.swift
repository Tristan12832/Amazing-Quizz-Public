//
//  CustomTextField.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 31/03/2024.
//

import SwiftUI

struct CustomTextField: View {
    
    var title: String
    var titleTextField: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(.title2, design: .rounded, weight: .bold))
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)

            TextField(titleTextField, text: $text)
                .padding()
                .scrollContentBackground(.hidden)
                .background(.backgroundColor4, in: RoundedRectangle(cornerRadius: 16))
                .padding(4)
                .background(.backgroundColor3, in: RoundedRectangle(cornerRadius: 16))
        }
    }
}
#Preview("CustomTextField") {
    CustomTextField(
        title: "Title of the question collection",
        titleTextField: "Write your title",
        text: .constant("")
    )
}
