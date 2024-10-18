//
//  PreviewModifiers.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 18/10/2024.
//

import SwiftData
import SwiftUI

struct NavigationTrait: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        NavigationStack {
            content
        }
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var navigationTrait: Self = .modifier(NavigationTrait())
}

struct MockData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try! ModelContainer(for: QuestionCollection.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(QuestionCollection(
            icon: "moon.stars.fill",
            title: "Basics of Astronomy",
            questions: [
                MCQQuestion(
                    title: "Which planet is the largest in our Solar System?",
                    answers: [
                        Answer(title: "Earth", status: .incorrect),
                        Answer(title: "Mars", status: .incorrect),
                        Answer(title: "Jupiter", status: .correct),
                        Answer(title: "Venus", status: .incorrect)
                    ],
                    isAnswered: false,
                    questionAnswered: false,
                    hintOrCorrectAnswer: "The largest planet is gas giant.",
                    index: 0
                ),
                MCQQuestion(
                    title: "How long does it take for Earth to orbit the Sun?",
                    answers: [
                        Answer(title: "One year", status: .correct),
                        Answer(title: "Two years", status: .incorrect),
                        Answer(title: "Six months", status: .incorrect),
                        Answer(title: "Three years", status: .incorrect)
                    ],
                    isAnswered: false,
                    questionAnswered: false,
                    hintOrCorrectAnswer: "It takes 365 days for a complete orbit.",
                    index: 1),
                MCQQuestion(
                    title: "Which planet has the most rings?",
                    answers: [
                        Answer(title: "Mercury", status: .incorrect),
                        Answer(title: "Pluto", status: .incorrect),
                        Answer(title: "Saturn", status: .correct),
                        Answer(title: "Uranus", status: .incorrect)
                    ],
                    isAnswered: false,
                    questionAnswered: false,
                    hintOrCorrectAnswer: "This planet is also known for its visible ring system when viewed through a telescope.",
                    index: 2
                ),
                MCQQuestion(
                    title: "What is the average distance from the Earth to the Sun?",
                    answers: [
                        Answer(title: "About 93 million miles", status: .correct),
                        Answer(title: "About 39 million miles", status: .incorrect),
                        Answer(title: "About 140 million miles", status: .incorrect),
                        Answer(title: "About 500 million miles", status: .incorrect)
                    ],
                    isAnswered: false,
                    questionAnswered: false,
                    hintOrCorrectAnswer: "This distance is also known as an Astronomical Unit.",
                    index: 3
                ),
                MCQQuestion(
                    title: "What is the final stage in the life cycle of a massive star?",
                    answers: [
                        Answer(title: "Red Giant", status: .incorrect),
                        Answer(title: "Supernova", status: .correct),
                        Answer(title: "Black Hole", status: .incorrect),
                        Answer(title: "White Dwarf", status: .incorrect)
                    ],
                    isAnswered: false,
                    questionAnswered: false,
                    hintOrCorrectAnswer: "This explosive event may outshine the entire galaxy.",
                    index: 4
                )
            ],
            commentary: "This collection covers fundamental concepts in astronomy.",
            color: "#1A22E5",
            score: 0.0,
            correctAnswersCount: 0,
            incorrectAnswersCount: 0,
            unansweredQuestion: 0,
            isFavorite: false,
            isComplet: false,
            isWin: false
        ))
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockData())
}
