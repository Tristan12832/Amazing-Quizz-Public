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
    
    
    var body: some View {
        NavigationSplitView {
            QuestionCollectionSortingView(sort: sortOrder, searchString: searchText)
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
        } detail: {
            ContentUnavailableView("No selection", systemImage: "folder.fill")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.backgroundColor5)
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)
    @State var question: QuestionCollection?
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
    
    return QuestionCollectionLandscapeView()
    .modelContainer(container)
}

//struct QuestionCollectionSidebarView: View {
//    @Query(sort: [
//        SortDescriptor(\QuestionCollection.title, order: .forward),
//        SortDescriptor(\QuestionCollection.title, order: .reverse)
//    ]) var questionCollections: [QuestionCollection]
//    
//    init(sort: SortDescriptor<QuestionCollection>, searchString: String = "") {
//        _questionCollections = Query(filter: #Predicate {
//            if searchString.isEmpty {
//                true
//            } else {
//                $0.title.localizedStandardContains(searchString)
//            }
//        }, sort: [sort])
//    }
//    
//    var body: some View {
//        List(questionCollections) { collection in
//            ZStack(alignment: .center) {
//                NavigationLink {
//                    QuestionCollectionDetailView(questionCollection: collection)
//                } label: {
//                    EmptyView()
//                }
//                .opacity(0)
//                QuestionCellListView(questionCollection: collection)
//            }
//            .listRowInsets(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
//            .listRowSeparator(.hidden)
//            .listRowBackground(Color.backgroundColor5)
//            
//        }
//        .scrollContentBackground(.hidden)
//        .background(.backgroundColor5)
//        .scrollIndicators(.hidden)
//        .contentMargins([.horizontal, .bottom], 10, for: .scrollContent)
//        .toolbarBackground(.backgroundColor5.opacity(0.5))
//    }
//}
