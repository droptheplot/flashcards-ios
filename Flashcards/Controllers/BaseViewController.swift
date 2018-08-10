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
}
