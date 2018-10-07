//
//  RepositoryTests.swift
//  FlashcardsTests
//
//  Created by Sergei Novikov on 05/10/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import XCTest
@testable import Flashcards

class RepositoryTests: XCTestCase {
  var repository: Repository!
  var urlSession: URLSessionProtocolMock!

  override func setUp() {
    urlSession = URLSessionProtocolMock()
    urlSession.dataTaskWithCompletionHandlerReturnValue = URLSessionDataTaskProtocolMock()
    
    repository = Repository(baseURL: URL(string: "api")!, urlSession: urlSession)
  }

  func testCreateToken() {
    let email = "email", password = "password"
    
    repository.createToken(email: email, password: password) {_ in }
    
    var request = URLRequest(url: URL(string: "api/tokens")!)
    request.httpMethod = "POST"
    request.httpBody = String(format: "email=%@&password=%@", email, password).data(using: String.Encoding.utf8)
    
    XCTAssertEqual(urlSession.dataTaskWithCompletionHandlerReceivedArguments?.request, request)
  }
  
  func testCreateUser() {
    let email = "email", password = "password"
    
    repository.createUser(email: email, password: password) {_ in }
    
    var request = URLRequest(url: URL(string: "api/users")!)
    request.httpMethod = "POST"
    request.httpBody = String(format: "email=%@&password=%@", email, password).data(using: String.Encoding.utf8)
    
    XCTAssertEqual(urlSession.dataTaskWithCompletionHandlerReceivedArguments?.request, request)
  }
  
  func testGetSources() {
    repository.getSources() {_ in }

    let request = URLRequest(url: URL(string: "api/sources")!)

    XCTAssertEqual(urlSession.dataTaskWithCompletionHandlerReceivedArguments?.request, request)
  }
  
  func testGetSource() {
    let id = Int.random(in: 0...10)
    let token = "token"
      
    repository.getSource(id: id, token: token) {_ in }
    
    var request = URLRequest(url: URL(string: "api/sources/\(id)")!)
    request.addValue(token, forHTTPHeaderField: "Authorization")

    XCTAssertEqual(urlSession.dataTaskWithCompletionHandlerReceivedArguments?.request, request)
  }
  
  func testAddCardToUser() {
    let cardID = Int.random(in: 0...10)
    let token = "token"

    repository.addCardToUser(cardID: cardID, token: token, correct: true) { _ in }

    var request = URLRequest(url: URL(string: "api/cards/\(cardID)/correct")!)
    request.httpMethod = "POST"
    request.addValue(token, forHTTPHeaderField: "Authorization")

    XCTAssertEqual(urlSession.dataTaskWithCompletionHandlerReceivedArguments?.request, request)

    repository.addCardToUser(cardID: cardID, token: token, correct: false) { _ in }

    request.url = URL(string: "api/cards/\(cardID)/incorrect")!
    
    XCTAssertEqual(urlSession.dataTaskWithCompletionHandlerReceivedArguments?.request, request)
  }
}
