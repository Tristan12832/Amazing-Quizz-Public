//
//  QuestionCellView.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 11/02/2024.
//

import SwiftData
import SwiftUI

struct QuestionCellView: View {
    var index: Int

    var numberLineLimit: Int
 
    @Bindable var question: MCQQuestion
    
    var body: some View {
        HStack(alignment: .center) {
            HStack(spacing: 4) {
                Image(systemName: "\(index + 1).circle.fill")
                    .font(.system(size: 24))
                
                Text(question.title)
                    .lineLimit(numberLineLimit)
                    .frame(minHeight: 60)
                    .frame(maxHeight: 100)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .offset(x: -10)
            
            Spacer()
            
            if question.isAnswered {
                Image(systemName: question.questionAnswered ? "checkmark" : "xmark")
                    .foregroundStyle(question.questionAnswered ? .green : .red)
            }
        }
        .font(.system(.headline, design: .default, weight: .semibold))
        .foregroundStyle(.primary)
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundColor1))
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.backgroundColor2, lineWidth: 4)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 100)
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            """
            Question number\(question.index + 1), \(question.title), \(question.questionAnswered ? "is correct!":"is incorrect!")
            """
        )
    }
}

#Preview {
    do {
        let preview = try Previewer()
        return QuestionCellView(index: 0, numberLineLimit: 3, question: preview.question)
            .modelContainer(preview.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
