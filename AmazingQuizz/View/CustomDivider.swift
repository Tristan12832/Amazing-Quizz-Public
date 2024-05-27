//
//  CustomDivider.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 10/02/2024.
//
// //MARK: Note:
// This component comes from project 8, part 3, “Merging Codable structs”, of Paul Hudson's 100 days of Hacking with Swift.
// https://www.hackingwithswift.com/books/ios-swiftui/merging-codable-structs

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
