//
//  Repository.swift
//  Flashcards
//
//  Created by Sergei Novikov on 26/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

class Repository {
  var baseURL: URL
  var urlSession: URLSessionProtocol
  
  enum Error: Swift.Error {
    case ServerError
    case NotFound
    case UnprocessableEntity
  }
  
  init(baseURL: URL, urlSession: URLSessionProtocol) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }
}
