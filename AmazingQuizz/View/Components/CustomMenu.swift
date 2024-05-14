//
//  CustomMenu.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 12/05/2024.
//

import SwiftUI

struct CustomMenu: View {
    
    @Binding public var sortOrder: SortDescriptor<QuestionCollection>
    
    var body: some View {
        Menu {
            Picker("Sort", selection: $sortOrder) {
                Text("A-Z")
                    .tag(SortDescriptor(\QuestionCollection.title, order: .forward))
                
                Text("Inverse")
                    .tag(SortDescriptor(\QuestionCollection.title, order: .reverse))
            }
            .pickerStyle(.inline)
        } label: {
            Image(systemName: "slider.horizontal.3")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.accentColor)
                .shadow(radius: 10)
        }
        .accessibilityLabel("Sorting parameter")
    }
}
