//
//  PageQuestionView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/04/2024.
//

import SwiftData
import SwiftUI

struct PageQuestionView: View {
    var collection: QuestionCollection
    var questions: [MCQQuestion] {
        return collection.questions
            .sorted(by: {$0.index < $1.index})
    }
    var indexPage: Int
    
    var body: some View {
        ForEach(questions.indices, id: \.self) { questionIndex in

            ScrollView {
                VStack {
                    QuestionContent(question: questions[questionIndex], questionNumber: indexPage + 1, totalQuestions: questions.count)
                        .padding(.vertical)
                    
                    AnswerViews(question: questions[questionIndex], checkQuestionAction: checkQuestion)
                        .id(questionIndex)
                        .padding(.vertical)
                    
                    VStack {
                        Button("Reset") {
                            withAnimation (.bouncy(duration: 0.66)){
                                restGame(questions[questionIndex])
                            }
                        }
                        .buttonStyle(.customButtonStyle_OrangeBouncy)
                        .accessibilityHint("Press ‘reset’ to reset the current question.")

                    }
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden)
            }
        }
    }
    
    private func checkQuestion(_ answerIndex: Int, _ question: MCQQuestion) {
        guard let index = questions.firstIndex(where: { $0.id == question.id }) else { return }
        let correctAnswer = question.correctAnswer
        let selectedAnswer = question.answers[answerIndex]
        
        if selectedAnswer == question.correctAnswer {
            questions[index].hintOrCorrectAnswer = "Win"
            questions[index].isAnswered = true
        } else {
            questions[index].hintOrCorrectAnswer = "Faill, the correct answer was \(correctAnswer?.title ?? "")."
            questions[index].isAnswered = false
        }
        questions[index].questionAnswered = true
    }
    
    private func restGame(_ question: MCQQuestion) {
        guard let index = questions.firstIndex(where: { $0.id == question.id }) else { return }
        questions[index].hintOrCorrectAnswer = ""
        questions[index].isAnswered = false
        questions[index].questionAnswered = false
        for answerIndex in questions[index].answers.indices {
            questions[index].answers[answerIndex].isAnswered = false
        }
    }
}

#Preview("Page_Question_Preview") {
    do {
        let preview = try Previewer()
        return PageQuestionView(collection: preview.questionCollection_Simple, indexPage: 0)
            .modelContainer(preview.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

struct QuestionContent: View {
    var question: MCQQuestion
    var questionNumber: Int
    var totalQuestions: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            VStack {
                Text("Question !")
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
                Text("\(questionNumber) / \(totalQuestions)")
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
            }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Question \(questionNumber) on \(totalQuestions)")
                .accessibilityAddTraits(.isHeader)
            
            Text(question.title)
                .font(.system(.title, design: .rounded, weight: .bold))
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h1)
            
            Text(question.hintOrCorrectAnswer)
                .font(.system(.title, design: .rounded, weight: .bold))
                .padding(.vertical)
                .animation(.snappy(duration: 0.80), value: question.isAnswered)
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)
        }
    }
}

struct AnswerViews: View {
    var question: MCQQuestion
    // This action must be passed to the view.
    var checkQuestionAction: (Int, MCQQuestion) -> Void

    var answers: [Answer] {
        return question.answers
    }
    
    var body: some View {
        VStack {
            ForEach(answers.indices, id: \.self) { index in
                AnswerCellView(answer: answers[index]) {
                    self.checkQuestionAction(index, self.question)
                }
                .id(index)
            }
            .disabled(question.questionAnswered)
        }
    }
}
