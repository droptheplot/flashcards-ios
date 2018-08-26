//
//  BaseViewController.swift
//  flashcards
//
//  Created by Sergei Novikov on 21/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  let sourceRepository = SourceRepository(baseURL: "http://localhost:8080/api/v1")
  let tokenRepository = TokenRepository(baseURL: "http://localhost:8080/api/v1")
  let cardRepository = CardRepository(baseURL: "http://localhost:8080/api/v1")
  let baseColor = UIColor(red: 1.00, green: 0.18, blue: 0.57, alpha: 1.0)
}
