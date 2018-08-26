//
//  CardRepository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 25/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

class CardRepository {
  var baseURL: String
  
  init(baseURL: String) {
    self.baseURL = baseURL
  }
  
  func addCardToUser(cardID: Int, token: String, correct: Bool, done: @escaping (_ err: Error?) -> ()) {
    var request = URLRequest(url: URL(string: String(format: "%@/cards/%d/%@", self.baseURL, cardID, correct ? "correct" : "incorrect"))!)
    request.httpMethod = "POST"
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let _ = data, error == nil else {
        done(RepositoryError.ServerError)
        return
      }
      
      done(nil)
    }
    
    task.resume()
  }
}
