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
}
