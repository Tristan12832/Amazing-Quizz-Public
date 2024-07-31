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
                .navigationSplitViewColumnWidth(min: 320, ideal: 350, max: 400)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add a new quiz collection", systemImage: "plus") {
                            self.showNewCollection = true
                        }
                        .buttonStyle(ToolbarButtonStyle())
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
            ContentUnavailableView("No selection", systemImage: "folder.fill")
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
