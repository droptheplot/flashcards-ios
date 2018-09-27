//
//  BaseViewController.swift
//  flashcards
//
//  Created by Sergei Novikov on 21/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  let repository = Repository(baseURL: URL(string: "http://localhost:8080/api/v1")!, urlSession: URLSession.shared)
  let baseColor = UIColor(red: 1.00, green: 0.18, blue: 0.57, alpha: 1.0)
  let successColor = UIColor(red: 0.0, green: 0.98, blue: 0.57, alpha: 1.0)
}
