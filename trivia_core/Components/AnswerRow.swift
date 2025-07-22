//
//  AnswerRow.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 17/06/25.
//

import Foundation
import SwiftUI
struct AnswerRow: View {
    var answer: Answer
    @State private var isSelected = false
    
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.711)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            Image(systemName: "circle.fill")
            
            Text(answer.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(answer.isCorrect ? green : red)
            }
        }
        .padding()
        .frame (maxWidth: .infinity, alignment: .leading)
        .foregroundColor(isSelected ? .blue : .gray)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? (answer.isCorrect ? green : red) : .gray, radius: 10, x: 0.5, y:0.5)
        .onTapGesture {
            isSelected = true
        }
        
    }
}

#Preview {
    AnswerRow(answer: Answer(text: "SIngle", isCorrect: true ))
}
