//
//  PlayingQuestionView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 09/05/2024.
//

import SwiftData
import SwiftUI

struct PlayingQuestionView: View {
    @Binding var path: NavigationPath
    @State private var isBack: Bool = false
    
    public var question: MCQQuestion
    public var questions: [MCQQuestion]
    
    
    var body: some View {
        let currentIndex = questions.firstIndex(where: { $0.id == question.id })
        
        return ScrollView {
            VStack {
                QuestionContent(
                    question: question,
                    questionNumber: question.index + 1,
                    totalQuestions: questions.count
                )
                .padding(.vertical)
                
                AnswerViews2(
                    question: question,
                    checkQuestionAction: checkQuestion
                )
                .padding(.vertical)
                
                VStack {
                    Button("Reset") {
                        withAnimation (.bouncy(duration: 0.66)){
                            restGame(questions[question.index])
                        }
                    }
                    .buttonStyle(.customButtonStyle_OrangeBouncy)
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
        }
        .background {
            RadialGradient(colors: [Color.backgroundColor5.opacity(0.8), Color.backgroundColor1], center: .topLeading, startRadius: 300, endRadius: 550)
                .ignoresSafeArea()
                .accessibilityIgnoresInvertColors(true)
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if let currentIndex = currentIndex, currentIndex > 0 {
                    NavigationLink(destination: PlayingQuestionView(path: $path, question: questions[currentIndex - 1], questions: questions)) {
                        Label("Past", systemImage: "arrow.left")
                    }
                    .buttonStyle(NextOrPastButton(foregroundColor: .red))
                } else {
                    Button {
                        withAnimation {
                            path = NavigationPath()
                        }
                    } label: {
                        Label("Back", systemImage: "arrow.backward.circle.fill")
                    }
                    .buttonStyle(NextOrPastButton(foregroundColor: .primary))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let currentIndex = currentIndex, currentIndex < questions.count - 1 {
                    NavigationLink(destination: PlayingQuestionView(path: $path, question: questions[currentIndex + 1], questions: questions)) {
                        Label("Next", systemImage: "arrow.right")
                    }
                    .buttonStyle(NextOrPastButton(foregroundColor: .green))
                } else {
                    Button {
                        withAnimation {
                            path = NavigationPath()
                        }
                    } label: {
                        Label("Back", systemImage: "xmark.circle.fill")
                    }
                    .buttonStyle(NextOrPastButton(foregroundColor: .primary))
                }
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

#Preview("Preview") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MCQQuestion.self, configurations: config)

    let example = MCQQuestion(
        title: "Combien fait 2 +2 ?",
        answers: [
            Answer(
                title: "2",
                status: .incorrect,
                isAnswered: false
            ),
            Answer(
                title: "4",
                status: .correct,
                isAnswered: false
            ),
            Answer(
                title: "5",
                status: .incorrect,
                isAnswered: false
            )
        ],
        hintOrCorrectAnswer: "2 x 2", index: 0
    )
    container.mainContext.insert(example)
    
    return NavigationStack {
        PlayingQuestionView(path: .constant(NavigationPath()), question: example, questions: [example])
    }
        .modelContainer(container)
}

struct AnswerViews2: View {
    
    struct AnswerPlacement: Hashable, Identifiable {
        var id: Self { self }
        var index: Int
        var answer: Answer
    }
    
    var question: MCQQuestion
    // This action must be passed to the view.
    var checkQuestionAction: (Int, MCQQuestion) -> Void

    private var answerPlacements: [AnswerPlacement] {
        question.answers.indices.map { index in
            AnswerPlacement(index: index, answer: question.answers[index])
        }
    }
    
    var body: some View {
        VStack {
            ForEach(answerPlacements) { placement in
                AnswerCellView(answer: placement.answer) {
                    self.checkQuestionAction(placement.index, self.question)
                }
                .id(placement.answer.id)
            }
            .disabled(question.questionAnswered)
        }
    }
}
