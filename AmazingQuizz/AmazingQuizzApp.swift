//
//  AmazingQuizzApp.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 31/01/2024.
//

import SwiftData
import SwiftUI

@main
struct AmazingQuizzApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: QuestionCollection.self)
    }
}
