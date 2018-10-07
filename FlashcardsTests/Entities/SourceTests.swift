//
//  SourceTests.swift
//  FlashcardsTests
//
//  Created by Sergei Novikov on 07/10/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import XCTest
@testable import Flashcards

class SourceTests: XCTestCase {
  func testCardsCount() {
    var source: Source?
    XCTAssertEqual(0, source.cardsCount())

    source = Source(cards: nil)
    XCTAssertEqual(0, source.cardsCount())

    source = Source(cards: [])
    XCTAssertEqual(0, source.cardsCount())

    source = Source(cards: [Card()])
    XCTAssertEqual(1, source.cardsCount())
  }
}
