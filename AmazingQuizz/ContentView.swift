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

#Preview("Preview", traits: .mockData) {
    ContentView()
}
