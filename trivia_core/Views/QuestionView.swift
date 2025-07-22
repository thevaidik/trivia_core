//
//  QuestionView.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 24/05/25.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    var body: some View {
        VStack(spacing : 40) {
            HStack {
                Text("Trivia Game")
                    .lilacTitle()
                
                Spacer()
                
                Text("1 out of 10")
                    .foregroundColor(.blue)
                    .fontWeight(.heavy)
            }
            
            Progressbar(progress: 40)
            
            VStack(alignment: .leading, spacing:20){
                Text("Bulls are attracted to color red.")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                    
                AnswerRow(answer: Answer(text: "false", isCorrect: true))
                AnswerRow(answer: Answer(text: "true", isCorrect: false))
                
            }
            
            PrimaryButton(text: "Next Question")
            
            //Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(red: 0.98, green: 0.92, blue: 0.84))
        .navigationBarHidden(true)
    }
}

#Preview {
    QuestionView()
}
