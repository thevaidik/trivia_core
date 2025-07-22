//
//  Answer.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 17/06/25.
//

import Foundation

struct Answer: Identifiable{
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
