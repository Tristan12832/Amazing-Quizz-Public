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

    var questions: [MCQQuestion] {
        return collection.questions
            .sorted(by: {$0.index < $1.index})
    }

    var body: some View {
        NavigationStack {
            TabView(selection: $indexPage) {
                PageQuestionView(collection: collection, questions: questions, indexPage: indexPage)
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
                        .accessibilityHint("Press to move to the previous question.")
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
                        .accessibilityHint("Press to end the game and go to results.")
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
                        .accessibilityHint("Press to move on to the next question.")
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.hidden, for: .automatic)
        }
        .statusBarHidden()
    }
}

#Preview("Preview") {
    do {
        let preview = try Previewer()
        return MyTabViewOfQuestionView(collection: preview.questionCollection)
            .modelContainer(preview.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
