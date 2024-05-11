//
//  ResultView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/04/2024.
//

import SwiftData
import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss

    var questionCollection: QuestionCollection
    
    private var correctAnswersCount: Int {
        questionCollection.questions.filter { $0.isAnswered == true}.count
    }
    private var incorrectAnswersCount: Int {
        questionCollection.questions.filter {$0.isAnswered == false && $0.questionAnswered == true}.count
    }
    private var unansweredQuestion: Int {
        questionCollection.questions.filter{$0.questionAnswered == false}.count
    }
    private var scorePercentage: Double {
        
        if questionCollection.questions.isEmpty {
            return 0.0
        }
        return (Double(correctAnswersCount) / Double(questionCollection.questions.count)) * 100
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Title Question Collection")
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityHeading(.h1)
                
                VStack(alignment: .leading) {
                    Group {
                        Text("Number of question: \(questionCollection.questions.count)")
                        
                        Text("Success score : \(scorePercentage.formatted())%")
                    }
                    .font(.title)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("The number of questions in your collection is \(questionCollection.questions.count). Your score is \(scorePercentage.formatted())%.")
                    
                    Spacer()
                    
                    Text("More details:")
                        .font(.headline)
                        .underline()
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityHeading(.h2)
                    
                    Text("Correct Question: \(correctAnswersCount)")
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityHeading(.h3)
                    Text("Incorrect Question: \(incorrectAnswersCount)")
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityHeading(.h3)
                    Text("Unanswered question \(unansweredQuestion)")
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityHeading(.h3)
                }
                .font(.title2)
                
            }
            .padding(.top, 50)
            .padding(.bottom, 10)
            //MARK: Display all question of the collection (model) and implement accessibilty 
            ForEach(questionCollection.questions.indices, id: \.self) { i in
                Text("\(i + 1)")
                    .font(.title)
            }
            .padding(.bottom, 10)
            
            Button("Back Detail Collection") {
                //MARK: Back detail (NavigationPath())
            }
            .buttonStyle(ItemToolbar(color: .white))
            .padding(.vertical, 20)
            
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "xmark")
                }
                .buttonStyle(NextOrPastButton( foregroundColor: .primary))
            }
        }
        //MARK: Add to other stats
        .onAppear {
            let collection = questionCollection
            collection.score = scorePercentage
            collection.correctAnswersCount = correctAnswersCount
            collection.incorrectAnswersCount = incorrectAnswersCount
            collection.unansweredQuestion = unansweredQuestion
        }
    }
}

#Preview("ResultView") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: QuestionCollection.self, configurations: config)
        
        let example = QuestionCollection(icon: "", title: "", commentary: "", color: "", isFavorite: false, isComplet: false, isWin: false)
        container.mainContext.insert(example)
        
        return ResultView(questionCollection: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
