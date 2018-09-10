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
    set {
      print("New token: \(String(describing: newValue))")
      UserDefaults.standard.set(newValue, forKey: "token")
    }
    get {
      return UserDefaults.standard.string(forKey: "token")
    }
  }
}
