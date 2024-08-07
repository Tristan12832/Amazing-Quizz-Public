//
//  MCQQuestion.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 01/04/2024.
//

import Foundation
import SwiftData

@Model class MCQQuestion {
    let id = UUID()
    var title: String
    @Relationship(deleteRule: .cascade, inverse: \Answer.MCQQuestion) var answers: [Answer]
    var isAnswered: Bool
    var questionAnswered: Bool
    var hintOrCorrectAnswer: String
    var QuestionCollection: QuestionCollection?
    var index: Int
    
    
    init(title: String, score: Double = 0.0, correctAnswersCount: Int = 0, incorrectAnswersCount: Int = 0, unansweredQuestion: Int = 0, answers: [Answer], isAnswered: Bool = false, questionAnswered: Bool = false, hintOrCorrectAnswer: String, QuestionCollection: QuestionCollection? = nil, index: Int) {
        self.title = title
        self.answers = answers.shuffled()
        self.isAnswered = isAnswered
        self.questionAnswered = questionAnswered
        self.hintOrCorrectAnswer = hintOrCorrectAnswer
        self.QuestionCollection = QuestionCollection
        self.index = index
    }
}

// Equatable and Comparable extensions
extension MCQQuestion: Equatable {
    static func == (lhs: MCQQuestion, rhs: MCQQuestion) -> Bool {
        lhs.id == rhs.id
    }
}

// Hashable conformance
extension MCQQuestion: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Correct answer computation
extension MCQQuestion {
    var correctAnswer: Answer? {
        return answers.first { $0.status == .correct }
    }
}
