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
  
  enum Error: Swift.Error {
    case ServerError
    case NotFound
    case UnprocessableEntity
  }
  
  init(baseURL: URL) {
    self.baseURL = baseURL
  }
}
