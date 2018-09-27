//
//  CardRepository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 25/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

extension Repository {
  func addCardToUser(cardID: Int, token: String, correct: Bool, done: @escaping (Result<Void, Repository.Error>) -> ()) {
    let path = String(format: "cards/%d/%@", cardID, correct ? "correct" : "incorrect")
    var request = URLRequest(url: self.baseURL.appendingPathComponent(path))
    request.httpMethod = "POST"
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let task = urlSession.dataTask(with: request) { data, response, error in
      guard let _ = data, error == nil else {
        done(.failure(.ServerError))
        return
      }
      
      done(.success(()))
    }
    
    task.resume()
  }
}
