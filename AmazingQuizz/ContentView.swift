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
    
    @State private var selection: QuestionCollection? = nil

    var body: some View {
        if prefersTabNavigation {
            QuestionCollectionListView()
        } else {
            QuestionCollectionLandscapeView( selection: $selection)
        }
    }
}

#Preview("Preview") {
    do {
        let preview = try Previewer()
        return ContentView()
            .modelContainer(preview.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    //        .environment(\.sizeCategory, .large)

}
