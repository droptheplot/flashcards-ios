//
//  Card.swift
//  flashcards
//
//  Created by Sergei Novikov on 21/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

struct Card: Codable {
  let id: Int
  let content: String
  
  let answersCount: Int
  let correctAnswersCount: Int
  let incorrectAnswersCount: Int 
}
