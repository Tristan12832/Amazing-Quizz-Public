//
//  ContentView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 31/01/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @Query(sort: \QuestionCollection.title) var questionCollections: [QuestionCollection]
    
    
    var body: some View {
        if prefersTabNavigation {
            QuestionCollectionListView(questionCollections: questionCollections)
        } else {
            QuestionCollectionLandscapeView(questionCollections: questionCollections)
        }
    }
}

#Preview("Preview") {
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
    
    return ContentView()
        .modelContainer(container)
    //        .environment(\.sizeCategory, .large)

}
