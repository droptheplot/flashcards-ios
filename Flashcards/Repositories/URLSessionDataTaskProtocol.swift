//
//  URLSessionDataTaskProtocol.swift
//  Flashcards
//
//  Created by Sergei Novikov on 27/09/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
  func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
