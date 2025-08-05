//
//  ContentView.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 23/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing:40 ) {
                VStack(spacing : 20){
                    Text("Trivia Game")
                        .lilacTitle()
                    
                    Text("Are you ready to test out your trivia skills?")
                        .foregroundColor(.blue)
                }
                
                NavigationLink {
                    
                    TriviaView()
                        .environmentObject(TriviaManager())
                } label:
                {
                    
                    PrimaryButton(text: "start it !")
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(red: 0.984, green: 0.929, blue: 0.847))
        }
    }
}

#Preview {
    ContentView()
}
