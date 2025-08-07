//
//  QuestionView.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 24/05/25.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager : TriviaManager


    var body: some View {
        VStack(spacing : 40) {
            HStack {
                
                Text("Trivia Game")
                    .lilacTitle()
                
                Spacer()
                
                Text("\(triviaManager.index + 1) out of \(triviaManager.length)")
                    .foregroundColor(.blue)
                    .fontWeight(.heavy)
            }
            
            Progressbar(progress: triviaManager.progress)
            
            VStack(alignment: .leading, spacing:20){
                
                if triviaManager.isLoading {
                    Text("Loading question...")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.gray)
                } else if let question = triviaManager.question {
                    Text(question)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.gray)
                } else {
                    Text("No question available")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.red)
                }
                
                ForEach(triviaManager.answerChoices, id:\.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(triviaManager)
                }
            }
             
            Button {
                triviaManager.goToNext()
            } label :{
                PrimaryButton(text: "Next Question") //addcolor if user is not answering and going next

            }
            .disabled(!triviaManager.answerSelectState)
                        
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
        .environmentObject(TriviaManager())
}
