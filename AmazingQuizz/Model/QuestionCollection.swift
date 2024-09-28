//
//  QuestionCollection.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/02/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model class QuestionCollection {
    var id = UUID()
    var icon: String
    @Attribute(.unique) var title: String
    @Relationship(deleteRule: .cascade, inverse: \MCQQuestion.QuestionCollection) var questions: [MCQQuestion]
    var commentary: String
    var color: String
    var score: Double //Push to CollectionModel
    var correctAnswersCount: Int //Push to CollectionModel
    var incorrectAnswersCount: Int //Push to CollectionModel
    var unansweredQuestion: Int //Push to CollectionModel
    var isFavorite: Bool
    var isComplet: Bool
    var isWin: Bool
   
    init(icon: String, title: String, questions: [MCQQuestion] = [MCQQuestion](), commentary: String, color: String, score: Double = 0.0, correctAnswersCount: Int = 0, incorrectAnswersCount: Int = 0, unansweredQuestion: Int = 0, isFavorite: Bool, isComplet: Bool, isWin: Bool) {
        self.icon = icon
        self.title = title
        self.questions = questions
        self.commentary = commentary
        self.color = color
        self.score = score
        self.correctAnswersCount = correctAnswersCount
        self.incorrectAnswersCount = incorrectAnswersCount
        self.unansweredQuestion = unansweredQuestion
        self.isFavorite = isFavorite
        self.isComplet = isComplet
        self.isWin = isWin
    }
}

extension QuestionCollection {
    var hexColor: Color {
        Color(hex: self.color) ?? Color.accentColor
    }
}

extension QuestionCollection: Equatable {
    static func == (lhs: QuestionCollection, rhs: QuestionCollection) -> Bool {
        return lhs.id == rhs.id
    }
}

extension QuestionCollection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
