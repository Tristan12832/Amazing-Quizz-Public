//
//  QuestionCollectionSortingView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 12/05/2024.
//

import SwiftData
import SwiftUI

struct QuestionCollectionSortingPhoneView: View {
    
    @Query(sort: [
        SortDescriptor(\QuestionCollection.title, order: .forward),
        SortDescriptor(\QuestionCollection.title, order: .reverse)
    ]) var questionCollections: [QuestionCollection]
    
    init(sort: SortDescriptor<QuestionCollection>, searchString: String = "") {
        _questionCollections = Query(filter: #Predicate {
            if searchString.isEmpty {
                true
            } else {
                $0.title.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    var body: some View {
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
        .toolbarBackground(.backgroundColor5.opacity(0.5))
        .contentMargins([.horizontal, .bottom], 10, for: .scrollContent)
    }
}

#Preview {
    QuestionCollectionSortingPhoneView(
        sort: SortDescriptor(\QuestionCollection.title),
        searchString: ""
    )
}
