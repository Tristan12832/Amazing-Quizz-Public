//
//  NewQuestionView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 31/03/2024.
//

import SwiftData
import SwiftUI

struct NewQuestionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var questionCollection: QuestionCollection
    
    //MARK: Next, I'd like to stay in this view to create a series of questions, one after the other...
    //    @State private var pushNextNewQuestionView = false
    
    @State private var counterAnswer = Array(repeating: 1, count: 1)
    
    //MARK: Question
    @State private var title = ""
    @State private var hintOrCorrectAnswer
    = ""
    
    //MARK: Answers
    @State private var answers = [Answer(title: "", status: .correct)]
    @State private var numberAnswer = 1
    @State private var statusAnswer: StatusAnswer = .correct
    @State private var answerTitle = Array(repeating: "", count: 1)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CustomTextField(
                        title: "Title of your question",
                        titleTextField: "Write the title of your question.",
                        text: $title
                    )
                    
                    CustomTextField(
                        title: "Hint or correct answer",
                        titleTextField: "Write your clue or correct answer.",
                        text: $hintOrCorrectAnswer
                    )
                    
                    CustomDivider()
                    
                    VStack(spacing: 0) {
                        HStack(alignment: .top, spacing: 0) {
                            Spacer()
                            Text("Your answers")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                                .accessibilityHeading(.h1)
                            
                            Spacer()
                        }
                        .offset(y: -16)
                        Text(
                                                """
                                                Add the number of answers you want.
                                                
                                                **Tip: we advise you to limit your answers to a maximum of 5.**
                                                """
                        )
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, -2)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Number of Answer: \(answers.count)")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .underline()
                            .padding(.vertical, 2)
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityHeading(.h2)
                        
                        ForEach($answers.indices, id: \.self) { index in
                            CcustomTextFieldOfAnswer(
                                statusAnswer: $answers[index].status,
                                answer: $answers[index].title,
                                numberAnswer: $counterAnswer[index]
                            )
                        }
                        
                        VStack {
                            HStack(spacing: 0){
                                Spacer()
                                
                                Button("Add a answer", systemImage: "plus") {
                                    answers.append(Answer(title: "", status: .correct))
                                    counterAnswer.append(1)
                                }
                                .buttonStyle(.customButtonStyle_OrangeBouncy)
                                .opacity(!questionIsEmpty ? 0.4 : 1)
                                .disabled(!questionIsEmpty)
                                .accessibilityHint(!questionIsEmpty ? "To add a second answer, you must fill out the text fields, the 'Title question', and  the 'hint or correct answer'." : "")

                                Spacer()
                            }
                            .padding(.top)
                            .padding(.horizontal, 60)
                        }
                        
                        if !questionIsEmpty {
                            Text("Fill in the text fields \"title question\", \"correct answer\", and write your first proposed answer.")
                                .font(.subheadline)
                                .foregroundStyle(.red)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            .scrollContentBackground(.hidden)
            .toolbarBackground(.backgroundColor5, for: .bottomBar, .navigationBar)
            .background(.backgroundColor5)
    //MARK: Next, I'd like to stay in this view to create a series of questions, one after the other...
            //            .navigationDestination(isPresented: $pushNextNewQuestionView) {
            //                NewQuestionView(questionCollection: questionCollection)
            //                        }
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("New Question!")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(CustomStyleToolbarItem_Simple(color: .primary))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addQuestion()
                        dismiss()
                    } label: {
                        Label("Save the question", systemImage: "square.and.arrow.down")
                    }
                    .buttonStyle(CustomStyleToolbarItem_Simple(color: .accent))
                    .opacity(!isCorrectQuestion ? 0.4 : 1)
                    .disabled(!isCorrectQuestion)
                    .accessibilityHint(!isCorrectQuestion ? "To save the new question to your collection, you must complete the two text fields: 'Title Question' and 'Hint or Correct Answer'. Additionally, you need to create at least two answers—one correct and one incorrect—before you can save your question." : "")

                }
            }
    //MARK: Next, j'aimerai rester dans cette vue pour créer à la chaine des questions, les une à la suite des autres...
            //            .toolbar {
            //                ToolbarItemGroup(placement: .bottomBar) {
            //                    HStack {
            //                        Spacer()
            //                        Button {
            //                            addQuestion()
            //                            pushNextNewQuestionView = true
            //                        } label: {
            //                            Label("Add agin a new question", systemImage: "plus")
            //                        }
            //                        .buttonStyle(CustomStyleToolbarItem_Simple(color: .complementary))
            //                    }
            //                }
            //            }
        }
    }
    
    private var questionIsEmpty: Bool {
        !title.isEmpty && !hintOrCorrectAnswer.isEmpty
    }
    
    private var isCorrectQuestion: Bool  {
        questionIsEmpty && answers.contains(where: {
            $0.status == .correct
        }) && answers.contains(where: {
            $0.status == .incorrect
        })
    }
    
    private func addQuestion() {
        let newQuestion = MCQQuestion(
            title: title,
            answers: answers,
            hintOrCorrectAnswer: hintOrCorrectAnswer,
            index: questionCollection.questions.count
        )
        questionCollection.questions.append(newQuestion)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: MCQQuestion.self, configurations: config)
        
        let example = QuestionCollection(icon: "", title: "", commentary: "", color: "", isFavorite: false, isComplet: false, isWin: false)
        container.mainContext.insert(example)
        
        return NewQuestionView(questionCollection: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
