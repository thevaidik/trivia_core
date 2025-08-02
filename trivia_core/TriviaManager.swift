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
    
    func fetchTrivia() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=9&difficulty=medium&type=multiple") else {
            fatalError ("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError ("Error")}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from : data)
            
            DispatchQueue.main.async {
                self.trivia = decodedData.results
                self.length = self.trivia.count
            }
            
        }
        catch {
            print("Error fetching data: \(error)")
        }
    }
}


