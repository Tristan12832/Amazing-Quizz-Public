//
//  AnswerCellView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 03/04/2024.
//

import SwiftData
import SwiftUI

struct AnswerCellView: View {
    var answer: Answer
        
    var color: Color {
        switch answer.status {
        case .correct:
                .green
        case .incorrect:
                .red
        }
    }
    
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
            answer.isAnswered.toggle()
        } label: {
            Text(answer.title)
                .font(.largeTitle.bold())
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray5))
                .clipShape(.capsule)
                .foregroundStyle(answer.isAnswered ? color : .primary)
                .padding(6)
                .background(answer.isAnswered ? color : Color(.systemGray4))
                .clipShape(.capsule)
                .shadow(radius: answer.isAnswered ? 0 : 8)
                .animation(.easeInOut, value: answer.isAnswered)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Answer.self, configurations: config)
    
    let example = Answer(
        title: "Test",
        status: .correct,
        isAnswered: false
    )
    container.mainContext.insert(example)
    
    return AnswerCellView(answer: example) {
        print("")
    }
    .modelContainer(container)
}

//MARK: Other model
struct AnswerCellView2: View {
    @Binding var isColorButton: Bool
    
    var title: String
    var color: Color
    
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
            isColorButton.toggle()
        } label: {
            Text(title)
                .font(.largeTitle.bold())
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray5))
                .clipShape(.capsule)
                .foregroundStyle(isColorButton ? color : .primary)
                .padding(6)
                .background(isColorButton ? color : Color(.systemGray4))
                .clipShape(.capsule)
                .shadow(radius: isColorButton ? 0 : 8)
                .animation(.easeInOut, value: isColorButton)
        }
    }
}
