//
//  QuestionCollectionSortingLandscapeView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 14/05/2024.
//

import SwiftData
import SwiftUI

struct QuestionCollectionSortingLandscapeView: View {
    
    @Query(sort: [
        SortDescriptor(\QuestionCollection.title, order: .forward),
        SortDescriptor(\QuestionCollection.title, order: .reverse)
    ]) var questionCollections: [QuestionCollection]
    
    init(sort: SortDescriptor<QuestionCollection>, searchString: String = "", selection: Binding<QuestionCollection?>) {
        _questionCollections = Query(filter: #Predicate {
            if searchString.isEmpty {
                true
            } else {
                $0.title.localizedStandardContains(searchString)
            }
        }, sort: [sort])
        _selection = selection
    }
    
    @Binding public var selection: QuestionCollection?
    
    var body: some View {
        List(questionCollections, selection: $selection) { collection in
            ZStack {
                NavigationLink(value: collection) {
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
        .toolbarBackground(.backgroundColor5.opacity(0.5))
        .contentMargins([.horizontal, .bottom], 10, for: .scrollContent)
    }
}

#Preview {
    @Previewable @State var selection: QuestionCollection?
    
    return QuestionCollectionSortingLandscapeView(
        sort: SortDescriptor(\QuestionCollection.title),
        searchString: "", selection: $selection)
}
