//
//  ProgressBar.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 24/05/25.
//

import Foundation
import SwiftUI

struct Progressbar: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 350, height: 4)
                .foregroundColor(Color(hue: 1.0 ,
                                       saturation: 0.0 , brightness: 0.564,
                                       opacity: 0.327))
                .cornerRadius(10)
            
            Rectangle()
                .frame(width: progress, height: 4)
                .foregroundColor(.blue)
                .cornerRadius(10)
        }
    }
}
 
#Preview {
    Progressbar(progress: 50)
}
