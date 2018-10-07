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

  init(answersCount: Int = 0, correctAnswersCount: Int = 0) {
    self.id = 0
    self.content = ""
    
    self.answersCount = answersCount
    self.correctAnswersCount = correctAnswersCount
  }
  
  func correctPercentage() -> Double {
    return Double(correctAnswersCount) / Double(answersCount) * 100.0
  }
}
