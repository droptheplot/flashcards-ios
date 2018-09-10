//
//  SourceRepository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 20/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

extension Repository {
  func getSources(done: @escaping (Result<[Source], RepositoryError>) -> ()) {
    let request = URLRequest(url: URL(string: self.baseURL + "/sources")!)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        done(.failure(.ServerError))
        return
      }

      do {
        let decoder = JSONDecoder()
        let sources: [Source] = try decoder.decode([Source].self, from: data)
        
        done(.success(sources))
      } catch {
        done(.failure(.NotFound))
      }
    }

    task.resume()
  }
  
  func getSource(id: Int, token: String, done: @escaping (Result<Source, RepositoryError>) -> ()) {
    var request = URLRequest(url: URL(string: self.baseURL + "/sources/" + String(id))!)
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        done(.failure(.ServerError))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let source: Source = try decoder.decode(Source.self, from: data)
        
        done(.success(source))
      } catch {
        done(.failure(.NotFound))
      }
    }
    
    task.resume()
  }
}
