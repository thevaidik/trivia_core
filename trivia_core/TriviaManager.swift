//
//  TriviaManager.swift
//  trivia_core
//
//  Created by Vaidik Dubey on 25/07/25.
//

import Foundation

class TriviaManager: ObservableObject {
    
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelectState = false
    @Published private(set) var selectedAnswer: Answer?
    @Published private(set) var question : AttributedString?
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress : CGFloat = 0
    @Published private(set) var score = 0
    @Published private(set) var isLoading = false
    
//    init() {
//        Task.init {
//            await fetchTrivia()
//        }
//    }
    
    init() {
        if trivia.isEmpty {
            Task {
                await fetchTrivia()
            }
        }
    }
    
    func fetchTrivia() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        print("Fetching trivia data...")
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=9&difficulty=medium&type=multiple") else {
            fatalError ("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            //guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError ("Error")}
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                return
            }

            guard httpResponse.statusCode == 200 else {
                if httpResponse.statusCode == 429 {
                    print("Rate limit exceeded. Please wait before making another request.")
                    // Optionally retry after a delay
                    try? await Task.sleep(nanoseconds: 5_000_000_000) // 5 second delay
                    await fetchTrivia() // Retry once
                    return
                } else {
                    print("Failed with status code: \(httpResponse.statusCode)")
                    return
                }
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from : data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.progress = 0
                self.score = 0
                self.reachedEnd = false
                self.isLoading = false
                
                self.trivia = decodedData.results
                self.length = self.trivia.count
                print("Successfully loaded \(self.length) trivia questions")
                self.setQuestion()
            }
            
        }
        catch {
            print("Error fetching data: \(error)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func goToNext() {
        print("goToNext called - current index: \(index), length: \(length)")
        if index + 1 < length {
            index += 1
            print("Moving to next question: \(index)")
            setQuestion()
        } else {
            print("Reached end of questions")
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelectState = false
        selectedAnswer = nil
        progress = CGFloat(Double(index + 1) / Double(length) * 360)
        
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
            print("Set question \(index + 1) of \(length)")
            print("Question: \(currentTriviaQuestion.question)")
            print("Answer choices count: \(answerChoices.count)")
        } else {
            print("Error: No questions available at index \(index)")
        }
    }
    
    func selectAnswer(answer: Answer) {
        print("Answer selected: \(answer.text), isCorrect: \(answer.isCorrect)")
        answerSelectState = true
        selectedAnswer = answer
        if answer.isCorrect {
            score += 1
            print("Score increased to: \(score)")
        }
    }
    
}


