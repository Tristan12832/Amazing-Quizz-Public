//
//  MCQQuestion.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 01/04/2024.
//

import Foundation
import SwiftData

@Model class MCQQuestion {
    var id = UUID()
    var title: String
    @Relationship(deleteRule: .cascade, inverse: \Answer.MCQQuestion) var answers = [Answer]()
    var isAnswered: Bool
    var questionAnswered: Bool
    var hintOrCorrectAnswer: String
    var QuestionCollection: QuestionCollection?
    var index: Int
    
    var correctAnswer: Answer {
        answers.first(where: { $0.status == .correct }) ?? answers[0]
    }
    
    init(
        id: UUID = UUID(),
        title: String,
        score: Double = 0.0,
        correctAnswersCount: Int = 0,
        incorrectAnswersCount: Int = 0,
        unansweredQuestion: Int = 0,
        answers: [Answer],
        isAnswered: Bool = false,
        questionAnswered: Bool = false,
        hintOrCorrectAnswer: String,
        index: Int
    ) {
        self.id = id
        self.title = title
        self.answers = answers.shuffled()
        self.isAnswered = isAnswered
        self.questionAnswered = questionAnswered
        self.hintOrCorrectAnswer = hintOrCorrectAnswer
        self.index = index
    }
}
