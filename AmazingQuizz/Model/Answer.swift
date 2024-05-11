//
//  Answer.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 01/04/2024.
//

import Foundation
import SwiftData

@Model class Answer {
    var id = UUID()
    var title: String
    var status: StatusAnswer
    var isAnswered: Bool
    var MCQQuestion: MCQQuestion?
    
    init(title: String = "", status: StatusAnswer = .correct, isAnswered: Bool = false) {
        self.title = title
        self.status = status
        self.isAnswered = isAnswered
    }
}

enum StatusAnswer: String, RawRepresentable, CaseIterable, Codable {
    case correct = "Correct"
    case incorrect = "Incorrect"
}
