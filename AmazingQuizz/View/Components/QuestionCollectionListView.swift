//
//  QuestionCollectionListView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/02/2024.
//

import SwiftData
import SwiftUI

struct QuestionCollectionListView: View {
//    @Query(sort: \QuestionCollection.title) var questionCollections: [QuestionCollection]
    var questionCollections: [QuestionCollection]
    
    @State private var searchText = ""
    
    @State private var showNewCollection = false
    
    var body: some View {
        NavigationStack {
            List(questionCollections) { collection in
                ZStack {
                    NavigationLink {
                        QuestionCollectionDetailView(questionCollection: collection)
                    } label: {
                        EmptyView()
                    }
                    .opacity(0)
                    QuestionCellListView(questionCollection: collection)
                }
                .listRowInsets(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.backgroundColor5)
            }
            .listStyle(.plain)
            .background(.backgroundColor5)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .background(.backgroundColor5)
            .contentMargins([.horizontal, .bottom], 10, for: .scrollContent)
            .toolbarBackground(.backgroundColor5.opacity(0.5))
            .navigationTitle("Your Quizz")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add a new quiz collection", systemImage: "plus") {
                        self.showNewCollection = true
                    }
                    .buttonStyle(toolbarButtonStyle())
                }
            }
            .sheet(isPresented: $showNewCollection) {
                NewQuestionCollectionView()
                    .presentationBackground(.regularMaterial)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for your quiz collection")
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

    return QuestionCollectionListView(questionCollections: [example])
        .modelContainer(container)
    //        .environment(\.sizeCategory, .large)
}
