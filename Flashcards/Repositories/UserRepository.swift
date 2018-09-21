//
//  UserRepository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 20/09/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

extension Repository {
  func createUser(email: String, password: String, done: @escaping (Result<Void, RepositoryError>) -> ()) {
    var request = URLRequest(url: URL(string: self.baseURL + "/users")!)
    request.httpMethod = "POST"
    request.httpBody = String(format: "email=%@&password=%@", email, password).data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let _ = data, error == nil else {
        done(.failure(.ServerError))
        return
      }
      
      if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
        done(.failure(.UnprocessableEntity))
        return
      }
      
      done(.success(()))
    }
    
    task.resume()
  }
}
