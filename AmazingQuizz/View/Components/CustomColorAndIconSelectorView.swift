//
//  CustomColorAndIconSelectorView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 31/03/2024.
//

import SwiftUI

struct CustomColorAndIconSelectorView: View {
    
    @Binding var colorIcon: Color
    @Binding var selectedIcon: String
    
    private let icons = [
        "house.fill",
        "tree.fill",
        "character.book.closed.fill",
        "graduationcap.fill",
        "gamecontroller.fill",
        "text.book.closed.fill",
        "magazine.fill",
        "menucard.fill",
        "newspaper.fill",
        "pencil.line",
        "pencil",
        "square.and.pencil",
        "scribble.variable",
        "folder.fill",
        "paperplane.fill",
        "tray.fill",
        "doc.fill",
        "doc.text.image.fill",
        "list.bullet.clipboard.fill",
        "doc.plaintext.fill",
        "apple.terminal.fill",
        "note",
        "book.fill",
        "books.vertical.fill",
        "book.closed.fill",
        "bookmark.fill",
        "pencil.and.ruler.fill",
        "studentdesk",
        "lanyardcard.fill",
        "cloud.fill",
        "briefcase.fill",
        "puzzlepiece.extension.fill"
    ]
    
    private let columns = [
        GridItem(.adaptive(minimum: 64, maximum: .infinity))
    ]
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Selecte your icon and this color for your new question collection!")
                .font(.system(.title2, design: .rounded, weight: .bold))
                .padding(.vertical, 8)
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)
            
            VStack(spacing: 0) {
                ColorPicker("Set the icon color", selection: $colorIcon, supportsOpacity: false)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .padding()
                
                LazyVGrid(columns: columns) {
                    ForEach(icons, id: \.self) { item in
                        Button {
                            selectedIcon = item
                        } label: {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 64, height: 64)
                                .foregroundStyle(item == selectedIcon ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
                                .overlay(
                                    Image(systemName: item)
                                        .foregroundStyle(item == selectedIcon ? colorIcon : .primary)
                                        .font(.system(size: 32))
                                        .fixedSize()
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .padding(4)
                                .background(item == selectedIcon ? colorIcon : .backgroundColor1, in: RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    .padding(.horizontal, 2)
                    
                }
                .padding(.horizontal, 4)
                .frame(maxHeight: .infinity)
            }
            .background(.backgroundColor3, in: RoundedRectangle(cornerRadius: 16))
            .padding(4)
            .background(.backgroundColor2, in: RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview("ColorIconPickerView") {
    @Previewable @State var colorIcon = Color.accent
    @Previewable @State var selectedIcon = ""
    
    return CustomColorAndIconSelectorView(colorIcon: $colorIcon, selectedIcon: $selectedIcon)
        .padding()
}
