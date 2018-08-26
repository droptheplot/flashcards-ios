//
//  SourceController.swift
//  Flashcards
//
//  Created by Sergei Novikov on 20/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit

class SourceViewController: BaseViewController {
  @IBOutlet weak var sourceTitleLabel: UILabel!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var cardsTableView: UITableView!
  @IBOutlet weak var sourceCardsCountLabel: UILabel!
  @IBOutlet weak var quizButton: UIButton!
  
  var id: Int?
  var source: Source?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    quizButton.layer.cornerRadius = 5
    
    repository.getSource(id: id!) { source in
      self.source = source

      DispatchQueue.main.async {
        self.sourceTitleLabel.text = self.source!.title
        self.navigationItem.title = self.source!.title

        if self.source!.cards == nil || self.source!.cards!.count == 0 {
          self.sourceCardsCountLabel.text = "No cards found."
          self.cardsTableView.isHidden = true
          self.quizButton.isEnabled = false
          self.quizButton.alpha = 0.5
        } else {
          self.sourceCardsCountLabel.text = String(format: "Cards: %d", self.source?.cards?.count ?? 0)
          self.cardsTableView.reloadData()
        }
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier != "openQuiz" else {
      return
    }
    
    let quizController = segue.destination as! QuizViewController
    quizController.source = source!
  }
}

extension SourceViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.source?.cards?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "card")
    cell.textLabel?.text = source!.cards![indexPath.row].content
    
    return cell
  }
}
