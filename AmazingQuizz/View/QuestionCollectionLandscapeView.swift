//
//  QuestionCollectionSidebarView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 08/04/2024.
//

import SwiftData
import SwiftUI

struct QuestionCollectionLandscapeView: View {
    @Query private var questionCollections: [QuestionCollection]

    @State private var sortOrder = SortDescriptor(\QuestionCollection.title)

    @State private var searchText = ""
    
    @State private var showNewCollection = false
    
    @Binding public var selection: QuestionCollection?

    var body: some View {
        NavigationSplitView {
            QuestionCollectionSortingLandscapeView(sort: sortOrder, searchString: searchText, selection: $selection)
                .navigationTitle("Your Quizz")
                .searchable(text: $searchText, placement: .sidebar, prompt: "Search for your quiz collection")
                .padding(.horizontal, 1)
                .background(.backgroundColor4)
                .navigationSplitViewColumnWidth(min: 360, ideal: 400, max: 600)
            #if !os(macOS)
                .tint(.selectionList)
            #endif
                .toolbar {
                    if !questionCollections.isEmpty {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Add a new quiz collection", systemImage: "plus") {
                                self.showNewCollection = true
                            }
                            .buttonStyle(ToolbarButtonStyle())
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
        } detail: {
            if let collection = selection {
                QuestionCollectionDetailView(questionCollection: collection)
            } else {
                Group {
                if !questionCollections.isEmpty {
                    ContentUnavailableView("No selection", systemImage: "folder.fill", description: Text("Select a question collection from the sidebar."))
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
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.backgroundColor5)
            }
        }
        .navigationSplitViewStyle(.balanced)
#if os(macOS)
        .frame(minWidth: 1000)
        .frame(minHeight: 600)
        .background()
#endif
    }
}

#Preview {
    @State var selection: QuestionCollection?
    do {
        let preview = try Previewer()
        return QuestionCollectionLandscapeView(selection: $selection)
            .modelContainer(preview.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
