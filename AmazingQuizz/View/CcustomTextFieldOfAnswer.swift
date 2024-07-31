//
//  CcustomTextFieldOfAnswer.swift
//  AmazingQuizz
//
//  Created by Tristan Stenuit on 01/04/2024.
//

import SwiftUI

struct CcustomTextFieldOfAnswer: View {
    
    @Binding var statusAnswer: StatusAnswer
    @Binding var answer: String
    @Binding var numberAnswer: Int
    
    private var colorTextField: Color {
        switch statusAnswer {
        case .correct:
                .green
        case .incorrect:
                .red
        }
    }
    
    var body: some View {
        Text("Answer n°\(numberAnswer)")
            .font(.system(.title2, design: .rounded, weight: .bold))
            .accessibilityAddTraits(.isHeader)
            .accessibilityHeading(.h3)
        
        HStack {
            TextField("Write your answer n°\(numberAnswer)", text: $answer)
                .foregroundStyle(colorTextField)
                .padding()
                .scrollContentBackground(.hidden)
            
            //MARK: ADD Status Answer
            Menu {
                Picker("Select response status", selection: $statusAnswer) {
                    ForEach(StatusAnswer.allCases, id: \.self) { item in
                        Label(item.rawValue.capitalized, image: "tag")
                            .tag(statusAnswer.rawValue)
                    }
                }
                .pickerStyle(.inline)
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundColor(Color.accentColor)
            }
        }
        .background(.backgroundColor4, in: RoundedRectangle(cornerRadius: 16))
        .padding(4)
        .background(.backgroundColor3, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CcustomTextFieldOfAnswer(statusAnswer: .constant(.correct), answer: .constant(""), numberAnswer: .constant(1))
}
