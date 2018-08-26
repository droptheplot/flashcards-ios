//
//  Store.swift
//  Flashcards
//
//  Created by Sergei Novikov on 26/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

class Store {
  static let instance = Store()
  
  var token: String? {
    didSet {
      print("New token: \(String(describing: token))")
    }
  }
}
