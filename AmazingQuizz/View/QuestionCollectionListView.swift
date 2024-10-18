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
            Group {
                if !questionCollections.isEmpty {
                    QuestionCollectionSortingPhoneView(sort: sortOrder, searchString: searchText)
                } else {
                    ContentUnavailableView(
                        label: {
                            Label("Creat", systemImage: "plus.rectangle.on.folder.fill")
                        },
                        description: {
                            Text("Creat your first question collection.")
                        },
                        actions: {
                            Button("Creat new collection", systemImage: "plus") {
                                self.showNewCollection = true
                            }
                            .buttonStyle(.bordered)
                        }
                    )
                    .background(.backgroundColor5)
                }
            }
                .toolbarBackground(.backgroundColor5.opacity(0.5))
                .navigationTitle("Your Quizz")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for your quiz collection")
                .toolbar {
                    if !questionCollections.isEmpty {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Add a new quiz collection", systemImage: "plus") {
                                self.showNewCollection = true
                            }
                            .buttonStyle(ToolbarButtonStyle())
                            .accessibilityHint("Press 'Add New Quiz Collection' to create a new quiz collection in your list within the application!")
                        }
                    }
                }
                .toolbar {
                    CustomMenu(sortOrder: $sortOrder)
                }
                .sheet(isPresented: $showNewCollection) {
                    NewQuestionCollectionView()
                        .presentationBackground(.regularMaterial)
                }
        }
    }
}

#Preview("MyPreview", traits: .sizeThatFitsLayout, .mockData) {
    QuestionCollectionListView()
}
