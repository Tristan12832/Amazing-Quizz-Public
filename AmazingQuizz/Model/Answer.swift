//
//  Answer.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 01/04/2024.
//

import Foundation
import SwiftData

@Model class Answer {
    let id = UUID()
    var title: String
    var status: StatusAnswer
    var isAnswered: Bool
    var MCQQuestion: MCQQuestion?
    
    init(title: String = "", status: StatusAnswer = .correct, isAnswered: Bool = false, MCQQuestion: MCQQuestion? = nil) {
        self.title = title
        self.status = status
        self.isAnswered = isAnswered
        self.MCQQuestion = MCQQuestion
    }
}

enum StatusAnswer: String, RawRepresentable, CaseIterable, Codable {
    case correct = "Correct"
    case incorrect = "Incorrect"
}

extension Answer: Equatable {
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.status == rhs.status && lhs.isAnswered == rhs.isAnswered && lhs.MCQQuestion == rhs.MCQQuestion
    }
}

extension Answer: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(status)
        hasher.combine(isAnswered)
        hasher.combine(MCQQuestion)
    }
}
