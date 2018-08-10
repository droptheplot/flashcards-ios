//
//  SourceController.swift
//  Flashcards
//
//  Created by Sergei Novikov on 20/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit

class SourceViewController: BaseViewController {
  @IBOutlet weak var sourceTitle: UILabel!
  @IBOutlet weak var backButton: UIButton!
  
  var id: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    sourceRepository.get(id: id!) { source in
      DispatchQueue.main.async {
        self.sourceTitle.text = source.title
      }
    }
  }
}
