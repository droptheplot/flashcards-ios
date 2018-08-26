//
//  TokenRepository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 21/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

extension Repository {
  func createToken(email: String, password: String, done: @escaping (_ token: String?, _ err: Error?) -> ()) {
    var request = URLRequest(url: URL(string: self.baseURL + "/tokens")!)
    request.httpMethod = "POST"
    request.httpBody = String(format: "email=%@&password=%@", email, password).data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        done(nil, RepositoryError.ServerError)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        var result: [String:String] = try decoder.decode([String:String].self, from: data)
        
        done(result["token"], nil)
      } catch {
        done(nil, RepositoryError.NotFound)
      }
    }
    
    task.resume()
  }
}
