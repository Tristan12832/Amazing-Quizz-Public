//
//  QuestionCellListView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 31/01/2024.
//

import SwiftData
import SwiftUI

struct QuestionCellListView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var questionCollection: QuestionCollection
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ZStack {
                    Image(systemName: questionCollection.icon)
                        .font(.system(size: 50))
                        .padding()
                        .frame(width: 100, height: 100)
                        .clipShape(.rect(cornerRadius: 16))
                        .background(.backgroundColor2)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding(4)
                        .background(.backgroundColor3)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding(.horizontal, 4)
                    .foregroundStyle(questionCollection.hexColor)
                    
                    if questionCollection.isWin {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.green)
                            .offset(x: 18, y:15)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(questionCollection.title)
                        .lineLimit(2)
                        .font(.system(.title2, weight: .bold))
                    Text(questionCollection.commentary)
                        .font(.subheadline)
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    if questionCollection.isComplet {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.blue)
                    }
                    if questionCollection.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.yellow)
                    }
                }
                .font(.system(size: 25))
                .offset(x: 0.0)
                
            }
            .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(.backgroundColor4)
        .clipShape(.rect(cornerRadius: 16))
        .padding(4)
        .background(.backgroundColor3)
        .clipShape(.rect(cornerRadius: 16))
//        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement()
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
                withAnimation(.easeOut) {
                    self.questionCollection.isFavorite.toggle()
                }
            } label: {
                if questionCollection.isFavorite {
                    Text("Remove Favorite")
                    Image(systemName: "heart.slash.fill")
                } else {
                    Text("Favorite")
                    Image(systemName: "heart.fill")
                    
                }
            }
            .tint(.yellow)
            
            Button {
                withAnimation(.easeOut) {
                    self.questionCollection.isComplet.toggle()
                }
            } label: {
                if questionCollection.isComplet {
                    Text("Remove Complet")
                    Image(systemName: "xmark.seal.fill")
                } else {
                    Text("Complet")
                    Image(systemName: "checkmark.seal.fill")
                    
                }
                
            }
            .tint(.blue)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                withAnimation(.linear) {
                    modelContext.delete(questionCollection)
                }
            } label: {
                Text("Delete")
                Image(systemName: "trash.fill")
            }
            .tint(.red)
        }
        #if os(macOS)
        .contextMenu {
            Button {
                withAnimation(.easeOut) {
                    self.questionCollection.isFavorite.toggle()
                }
            } label: {
                if questionCollection.isFavorite {
                    Label("Remove Favorite", systemImage: "heart.slash.fill")
                } else {
                    Label("Favorite", systemImage: "heart.fill")
                    
                }
            }
            
            Button {
                withAnimation(.easeOut) {
                    self.questionCollection.isComplet.toggle()
                }
            } label: {
                if questionCollection.isComplet {
                    Label("Remove Complet", systemImage: "xmark.seal.fill")
                } else {
                    Label("Complet", systemImage: "checkmark.seal.fill")
                }
            }
            Button(role: .destructive) {
                withAnimation(.linear) {
                    modelContext.delete(questionCollection)
                }
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
        }
        #endif
    }
}


#Preview("Light", traits: .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)

    let example = QuestionCollection(
        icon: "folder.fill",
        title: "My First Question in my app!",
        commentary: "The comments for the question are located here!",
        color: "#4c87b3",
        score: 0.0,
        correctAnswersCount: 0,
        incorrectAnswersCount: 0,
        unansweredQuestion: 0,
        isFavorite: true,
        isComplet: true,
        isWin: true
    )
    container.mainContext.insert(example)
    
    return QuestionCellListView(questionCollection: example)
        .modelContainer(container)
        .preferredColorScheme(.light)
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)

    let example = QuestionCollection(
        icon: "folder.fill",
        title: "My First Question in my app!",
        commentary: "The comments for the question are located here!",
        color: "#4c87b3",
        score: 0.0,
        correctAnswersCount: 0,
        incorrectAnswersCount: 0,
        unansweredQuestion: 0,
        isFavorite: true,
        isComplet: true,
        isWin: true
    )
    container.mainContext.insert(example)
    
    return QuestionCellListView(questionCollection: example)
        .modelContainer(container)
        .preferredColorScheme(.dark)
}

#Preview("List", traits: .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: QuestionCollection.self, configurations: config)

    let example = QuestionCollection(
        icon: "folder.fill",
        title: "My First Question in my app!",
        commentary: "The comments for the question are located here!",
        color: "#4c87b3",
        score: 0.0,
        correctAnswersCount: 0,
        incorrectAnswersCount: 0,
        unansweredQuestion: 0,
        isFavorite: true,
        isComplet: true,
        isWin: true
    )
    container.mainContext.insert(example)
    
    return List(0..<3) { _ in
        QuestionCellListView(
            questionCollection: example
        )
            .listRowInsets(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.backgroundColor5)
    }
    .padding(.horizontal, -16)
    .scrollContentBackground(.hidden)
    .background(.backgroundColor5)
    .scrollIndicators(.hidden)
    .modelContainer(container)
    .preferredColorScheme(.light)
}
