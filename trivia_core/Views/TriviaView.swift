//
//  TriviaView.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 17/07/25.
//

import Foundation
import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        if triviaManager.reachedEnd {
            VStack {
                
                Text("Game Over")
                    .lilacTitle()
                
                Text("You scored \(triviaManager.score) out of \(triviaManager.length)")
                
                Button {
                    
                    Task.init {
                        await triviaManager.fetchTrivia()
                    }
                    
                } label : {
                    PrimaryButton(text: "play again!")
                }
            }
        }
        
        else {
            QuestionView()
                .environmentObject(triviaManager)
        }
    }
}

#Preview {
    TriviaView()
        .environmentObject(TriviaManager())
}
