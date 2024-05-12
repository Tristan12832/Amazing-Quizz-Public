//
//  QuestionCollectionDetailView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 10/02/2024.
//

import SwiftData
import SwiftUI

struct QuestionCollectionDetailView: View {
    @Environment(\.dismiss) var dismiss

    var questionCollection: QuestionCollection
    
    @State private var showNewQuestion = false
    
    @State private var letGoPlaying = false
    
    private var questions: [MCQQuestion] {
        return questionCollection.questions
            .prefix(5)
            .sorted {
                $0.index < $1.index
            }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    IconView(questionCollection: questionCollection)
                    
                    DecDetailCollectionView(questionCollection: questionCollection, questions: questions)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
                
                Button("Show all questions ", systemImage: "magnifyingglass"){
                    
                }
                .buttonStyle(SecondeActionButtonStyle())
                
                CustomDivider()
                    .padding(.horizontal, 16)
                
                CustomMainActionButton(title: "Playing!", color: .accentColor) {
                    letGoPlaying = true
                }
                .padding(.horizontal, 16)
                
            }
            .scrollContentBackground(.hidden)
            .toolbarBackground(.backgroundColor5, for: .bottomBar, .navigationBar)
            .scrollIndicators(.hidden)
            .background(.backgroundColor5)
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $letGoPlaying) {
                MyTabViewOfQuestionView(collection: questionCollection)
            }
            .fullScreenCover(isPresented: $showNewQuestion, content: {
                NewQuestionView(questionCollection: questionCollection)
            })
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Favorite", systemImage: questionCollection.isFavorite ? "heart.fill" : "heart") {
                        withAnimation {
                            questionCollection.isFavorite.toggle()
                        }
                    }
                    .buttonStyle(CustomStyleToolbarItem_Simple(color: .yellow))
                    .accessibilityHint(questionCollection.isFavorite ? "Press favorite to unmark the collection as a favorite" : "Press favorite to mark the collection as a favorite.")

                    Button("Completed", systemImage: questionCollection.isComplet ? "checkmark.seal.fill" : "checkmark.seal") {
                        withAnimation {
                            questionCollection.isComplet.toggle()
                        }
                    }
                    .buttonStyle(CustomStyleToolbarItem_Simple(color: .blue))
                    .accessibilityHint(questionCollection.isComplet ? "Press complete to unmark the collection as a completed." : "Press complete to mark the collection as a completed.")

                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Back", systemImage: "arrow.backward.circle.fill")
                    }
                    .buttonStyle(CustomStyleToolbarItem_Simple(color: .primary))
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                self.showNewQuestion = true
                            }
                        } label: {
                            Label("Add agin a new question", systemImage: "plus")
                        }
                        .buttonStyle(CustomButtonStyle_BlueBouncy())
                        .accessibilityHint("Press to add a new question.")

                    }
                }
            }
        }
    }
}

#Preview("MyPreview",traits: .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)
    
    let questionCollection = QuestionCollection(
        icon: "folder.fill",
        title: "My First Question in my app!",
        questions: Array(
            repeating: MCQQuestion(
                title: "Question: TEST",
                answers: [],
                hintOrCorrectAnswer: "",
                index: 0
            ),
            count: 5
        ),
        commentary: "The comments for the question are located here!",
        color: "#4c87b3",
        isFavorite: true,
        isComplet: false,
        isWin: false
    )
    container.mainContext.insert(questionCollection)
    
//    let question = MCQQuestion(title: "", answers: [], hintOrCorrectAnswer: "", index: 0)
    
    return NavigationStack { QuestionCollectionDetailView(questionCollection: questionCollection)
    }
    .modelContainer(container)
    //        .environment(\.sizeCategory, .large)
    
}

#Preview("Preview") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)
    
    let questionCollection = QuestionCollection(
        icon: "folder.fill",
        title: "My First Question in my app!",
        commentary: "The comments for the question are located here!",
        color: "#4c87b3",
        isFavorite: true,
        isComplet: false,
        isWin: true
    )
    
    return QuestionCollectionDetailView(questionCollection: questionCollection)
        .modelContainer(container)
}


struct IconView: View {
    
    var questionCollection: QuestionCollection

    var body: some View {
        ZStack {
            Image(systemName: questionCollection.icon)
                .font(.system(size: 128))
                .foregroundStyle(Color(hex: questionCollection.color) ?? .gray)
                .fixedSize()
                .frame(width: 200, height: 200)
                .background(.backgroundColor3)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(4)
                .background(.backgroundColor4)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            if questionCollection.isWin {
                Image(systemName: "checkmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.green)
                    .offset(x: 55, y: 50)
            }
            
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Icon: \(questionCollection.icon)")
    }
}

struct DecDetailCollectionView: View {
    
    var questionCollection: QuestionCollection

    var questions: [MCQQuestion]

    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            Text(questionCollection.title)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .padding(.vertical)
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h1)
            
            Text("Commentary:")
                .font(.system(.title3, design: .rounded, weight: .bold))
                .underline()
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)
            
            Text(questionCollection.commentary)
                .lineLimit(10)
            
            CustomDivider()
            
            Text("All the questions in the collection")
                .font(.system(.title2, design: .rounded, weight: .bold))
                .underline()
                .padding(.vertical)
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)
            
            VStack {
                ForEach(questions.indices, id: \.self) { question in
                    QuestionCellView(
                        index: question,
                        numberLineLimit: 3,
                        question: questions[question]
                    )
                }
            }
            .padding(8)
            .padding(.horizontal, 4)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundColor3))
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.backgroundColor4, lineWidth: 4)
            }
        }
    }
}
