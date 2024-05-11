//
//  CustomTextEditor.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 31/03/2024.
//

import SwiftUI

struct CustomTextEditor: View {
    
    var title: String
    var titleTextField: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(.title2, design: .rounded, weight: .bold))
            TextField(titleTextField, text: $text, axis: .vertical)
                .lineLimit(10, reservesSpace: true)
                .padding()
                .scrollContentBackground(.hidden)
                .background(.backgroundColor4)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(4)
                .background(.backgroundColor3)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview("CustomTextEditor") {
    CustomTextEditor(
        title: "Title of the question collection",
        titleTextField: "Write your title",
        text: .constant("")
    )
}
