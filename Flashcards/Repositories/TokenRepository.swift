//
//  TokenRepository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 21/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

extension Repository {
  func createToken(email: String, password: String, done: @escaping (Result<String, Repository.Error>) -> ()) {
    var request = URLRequest(url: self.baseURL.appendingPathComponent("tokens"))
    request.httpMethod = "POST"
    request.httpBody = String(format: "email=%@&password=%@", email, password).data(using: String.Encoding.utf8)
    
    let task = urlSession.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        done(.failure(.ServerError))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        var result: [String:String] = try decoder.decode([String:String].self, from: data)
        
        done(.success(result["token"]!))
      } catch {
        done(.failure(.NotFound))
      }
    }
    
    task.resume()
  }
}
