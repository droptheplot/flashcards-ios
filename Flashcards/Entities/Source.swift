//
//  Source.swift
//  Flashcards
//
//  Created by Sergei Novikov on 20/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

struct Source: Codable {
  let id: Int
  let title: String
  let cards: [Card]?
  
  init(cards: [Card]? = nil) {
    self.id = 0
    self.title = ""
    self.cards = cards
  }
  
  func cardsCount() -> Int {
    return cards?.count ?? 0
  }
}

extension Optional where Wrapped == Source {
  func cardsCount() -> Int {
    return self?.cardsCount() ?? 0
  }
}
