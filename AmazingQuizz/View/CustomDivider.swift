//
//  CustomDivider.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 10/02/2024.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
                .frame(height: 2)
                .foregroundStyle(.backgroundColor2)
                .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
}
