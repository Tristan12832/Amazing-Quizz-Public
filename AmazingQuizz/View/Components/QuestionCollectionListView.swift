//
//  QuestionCollectionListView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/02/2024.
//

import SwiftData
import SwiftUI

struct QuestionCollectionListView: View {

    @Query private var questionCollections: [QuestionCollection]

    @State private var sortOrder = SortDescriptor(\QuestionCollection.title)

    @State private var searchText = ""
    
    @State private var showNewCollection = false
    
    var body: some View {
        NavigationStack {
            QuestionCollectionSortingView(sort: sortOrder, searchString: searchText)
                .toolbarBackground(.backgroundColor5.opacity(0.5))
                .navigationTitle("Your Quizz")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for your quiz collection")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add a new quiz collection", systemImage: "plus") {
                            self.showNewCollection = true
                        }
                        .buttonStyle(ToolbarButtonStyle())
                        .accessibilityHint("Press 'Add New Quiz Collection' to create a new quiz collection in your list within the application!")
                    }
                }
                .toolbar {
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
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("Sorting parameter")
                    .buttonStyle(ToolbarButtonStyle())

                }
                .sheet(isPresented: $showNewCollection) {
                    NewQuestionCollectionView()
                        .presentationBackground(.regularMaterial)
                }
        }
    }
}

#Preview("MyPreview", traits: .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)
    
    let example = QuestionCollection(
        icon: "folder.fill",
        title: "My First Question in my app!",
        commentary: "The comments for the question are located here!",
        color: "#4c87b3",
        isFavorite: true,
        isComplet: true,
        isWin: true
    )
    container.mainContext.insert(example)

    return QuestionCollectionListView()
        .modelContainer(container)
}
