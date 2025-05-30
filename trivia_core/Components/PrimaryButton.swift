//
//  PrimaryButton.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 23/05/25.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var background : Color = Color("AccentColor")
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal, 30)
            .background(.blue)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
     
}

#Preview {
    PrimaryButton(text: "Next")
}
