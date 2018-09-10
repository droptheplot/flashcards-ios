//
//  Result.swift
//  Flashcards
//
//  Created by Sergei Novikov on 10/09/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

enum Result<Value, Error: Swift.Error> {
  case success(Value)
  case failure(Error)
}
