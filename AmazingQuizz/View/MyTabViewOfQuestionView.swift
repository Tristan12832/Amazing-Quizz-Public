//
//  MyTabViewOfQuestionView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/04/2024.
//

import SwiftData
import SwiftUI

struct MyTabViewOfQuestionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var indexPage: Int = 0
    var collection: QuestionCollection

    var body: some View {
        NavigationStack {
            TabView(selection: $indexPage) {
                PageQuestionView(collection: collection, indexPage: indexPage)
                    .id(collection.id)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background {
                RadialGradient(colors: [Color.backgroundColor5.opacity(0.8), Color.backgroundColor1], center: .topLeading, startRadius: 300, endRadius: 550)
                    .ignoresSafeArea()
                    .accessibilityIgnoresInvertColors(true)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if indexPage == 0 {
                        Button {
                            dismiss()
                        } label: {
                            Label("Back", systemImage: "arrow.backward.circle.fill")
                        }
                        .buttonStyle(CustomStyleToolbarItem_Simple(color: .primary))
                    } else {
                        Button {
                            withAnimation(.bouncy(duration: 0.66)) {
                                if indexPage > collection.questions.startIndex {
                                    indexPage -= 1
                                }
                            }
                        } label: {
                            Label("Past", systemImage: "arrow.left")
                        }
                        .buttonStyle(NextOrPastButton(foregroundColor: .red))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if indexPage == collection.questions.count - 1 {
                        NavigationLink {
                            withAnimation (.bouncy(duration: 0.66)){
                                ResultView(questionCollection: collection)
                            }
                        } label: {
                            Label("Result", systemImage: "arrow.right")
                        }
                        .buttonStyle(NextOrPastButton(foregroundColor: .white))
                    } else {
                        Button {
                            withAnimation(.bouncy(duration: 0.66)) {
                                if indexPage < collection.questions.count - 1 {
                                    indexPage += 1
                                }
                            }
                        } label: {
                            Label("Next", systemImage: "arrow.right")
                        }
                        .buttonStyle(NextOrPastButton(foregroundColor: .green))
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .statusBarHidden()
    }
}

#Preview("Preview") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)
    
    let exampleCollection = QuestionCollection(
        icon: "folder.fill",
        title: "My First Question in my app!",
        questions: [MCQQuestion(
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
            hintOrCorrectAnswer: "", index: 0
        )],
        commentary: "The comments for the question are located here!",
        color: "#4c87b3",
        isFavorite: true,
        isComplet: true,
        isWin: true
    )
    container.mainContext.insert(exampleCollection)
    
    return MyTabViewOfQuestionView(collection: exampleCollection
    )
    .modelContainer(container)
}
