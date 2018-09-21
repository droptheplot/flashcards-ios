//
//  Error.swift
//  Flashcards
//
//  Created by Sergei Novikov on 21/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

enum RepositoryError: Error {
  case ServerError
  case NotFound
  case UnprocessableEntity
}
