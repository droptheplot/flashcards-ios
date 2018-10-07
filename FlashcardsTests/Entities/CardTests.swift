//
//  CardTests.swift
//  FlashcardsTests
//
//  Created by Sergei Novikov on 07/10/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import XCTest
@testable import Flashcards

class CardTests: XCTestCase {
  func testCorrectPercentage() {
    var card = Card(answersCount: 10, correctAnswersCount: 0)
    XCTAssertEqual(0.0, card.correctPercentage())

    card = Card(answersCount: 10, correctAnswersCount: 5)
    XCTAssertEqual(50.0, card.correctPercentage())

    card = Card(answersCount: 10, correctAnswersCount: 10)
    XCTAssertEqual(100.0, card.correctPercentage())
  }
}
