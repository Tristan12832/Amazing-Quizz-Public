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
    var questions: [MCQQuestion]
    var indexPage: Int
    
    var body: some View {
        ForEach(questions) { questionIndex in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    QuestionContent(
                        question: questionIndex,
                        questionNumber: indexPage + 1,
                        totalQuestions: questions.count
                    )
                        .padding(.vertical)
                    
                    AnswerViews(
                        question: questionIndex,
                        checkQuestionAction: checkQuestion
                    )
                        .id(questionIndex)
                        .padding(.vertical)
                    
                    VStack {
                        Button("Reset") {
                            withAnimation (.bouncy(duration: 0.66)){
                                restGame(questionIndex)
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

#Preview("Page_Question_Preview", traits: .navigationTrait, .mockData) {
    @Previewable @Query var questions: [MCQQuestion]
    PlayingQuestionView(path: .constant(NavigationPath()), question: questions[0], questions: questions)
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
    
    //    @Query private var answersOfQuestion: [Answer]
    //    var answers: [Answer] {
    //        return answersOfQuestion
    //            .filter { $0.MCQQuestion?.id == question.id }
    //    }
    
    var body: some View {
        VStack {
            ForEach(question.answers.indices, id: \.self) { index in
                AnswerCellView(answer: question.answers[index]) {
                    self.checkQuestionAction(index, self.question)
                }
                .id(question.answers[index].id)
            }
            .disabled(question.questionAnswered)
        }
    }
}
