//
//  NewQuestionCollectionView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/02/2024.
//

import SwiftData
import SwiftUI

struct NewQuestionCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var createCollectionAndQuestion = false
    
    @State private var title = ""
    @State private var icon = ""
    @State private var iconColor = Color.accent
    @State private var commentary = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    CustomTextField(
                        title: "Title of the question collection",
                        titleTextField: "Write your title",
                        text: $title
                    )
                    
                    CustomTextEditor(
                        title: "One commentary of the question collection?",
                        titleTextField: "Write your commentary",
                        text: $commentary
                    )
                    
                    CustomColorAndIconSelectorView(
                        colorIcon: $iconColor,
                        selectedIcon: $icon
                    )
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .center, spacing: 0) {
//                    CustomMainActionButton(
//                        title: "Creat!"
//                    ) {
//                        withAnimation {
//                            let newQuestionCollection = QuestionCollection(
//                                icon: icon,
//                                title: title,
//                                commentary: commentary,
//                                color: iconColor.toHexString()!,
//                                isFavorite: false,
//                                isComplet: false,
//                                isWin: false
//                            )
//                            modelContext.insert(
//                                newQuestionCollection
//                            )
//                            dismiss()
//                        }
//                    }
                        Button {
                            withAnimation {
                                let newQuestionCollection = QuestionCollection(
                                    icon: icon,
                                    title: title,
                                    commentary: commentary,
                                    color: iconColor.toHexString()!,
                                    isFavorite: false,
                                    isComplet: false,
                                    isWin: false
                                )
                                modelContext.insert(
                                    newQuestionCollection
                                )
                                dismiss()
                            }
                        } label: {
                            Label("Creat!", systemImage: "plus")
                        }
                        .buttonStyle(.customButtonStyle_OrangeBouncy)
                    .opacity(title.isEmpty ? 0.6 : 1)
                    .padding(20)
                    .disabled(title.isEmpty ? true : false)
                    
                    if title.isEmpty {
                        Text("You must at least complete the text field, \"title of the question collection\" to creat a new collection!")
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    }
                }
                .padding(.horizontal, 20)
                
            }
            .scrollContentBackground(.hidden)
            .toolbarBackground(.backgroundColor5)
            .background(.backgroundColor5)
            .navigationTitle("New collection!")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(CustomStyleToolbarItem_Simple(color: .primary))
                }
            }
        }
    }
}

#Preview("Principal View") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: QuestionCollection.self, configurations: config)
        
        let example = QuestionCollection(icon: "", title: "", commentary: "", color: "", isFavorite: false, isComplet: false, isWin: false)
        container.mainContext.insert(example)
        
        return NewQuestionCollectionView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
