//
//  URLSessionProtocol.swift
//  Flashcards
//
//  Created by Sergei Novikov on 27/09/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import Foundation

protocol URLSessionProtocol: AutoMockable {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
    return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
  }
}
