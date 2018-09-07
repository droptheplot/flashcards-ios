//
//  SourceRepository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 20/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

extension Repository {
  func getSources(done: @escaping (_ sources: [Source]) -> ()) {
    let request = URLRequest(url: URL(string: self.baseURL + "/sources")!)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        return
      }

      let decoder = JSONDecoder()
      var sources: [Source] = []

      sources = try! decoder.decode([Source].self, from: data)
      dump(sources)
      
      done(sources)
    }

    task.resume()
  }
  
  func getSource(id: Int, token: String, done: @escaping (_ source: Source) -> ()) {
    var request = URLRequest(url: URL(string: self.baseURL + "/sources/" + String(id))!)
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        return
      }
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      
      var source: Source
      
      source = try! decoder.decode(Source.self, from: data)
      dump(source)
      
      done(source)
    }
    
    task.resume()
  }
}
