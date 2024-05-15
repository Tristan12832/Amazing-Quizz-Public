//
//  Answer.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 01/04/2024.
//

import Foundation
import SwiftData

@Model class Answer {
    let id: String
    var title: String
    var status: StatusAnswer
    var isAnswered: Bool
    var MCQQuestion: MCQQuestion?
    
    init(id: String = UUID().uuidString, title: String = "", status: StatusAnswer = .correct, isAnswered: Bool = false, MCQQuestion: MCQQuestion? = nil) {
        self.id = id
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
        return lhs.id == rhs.id
    }
}

extension Answer: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
