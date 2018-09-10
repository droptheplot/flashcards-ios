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
  @IBOutlet weak var cardsTableView: UITableView!
  @IBOutlet weak var sourceCardsCountLabel: UILabel!
  @IBOutlet weak var quizButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  
  var id: Int?
  var source: Source?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    cardsTableView.separatorInset = UIEdgeInsets.zero
    quizButton.layer.cornerRadius = 5
    backButton.layer.cornerRadius = 5

    repository.getSource(id: id!, token: Store.instance.token!) { result in
      if case .success(let source) = result {
        self.source = source
      }

      DispatchQueue.main.async {
        self.sourceTitleLabel.text = self.source!.title

        if self.source!.cards == nil || self.source!.cards!.count == 0 {
          self.sourceCardsCountLabel.text = "No cards found."
          self.cardsTableView.isHidden = true
          self.quizButton.isHidden = true
        } else {
          self.sourceCardsCountLabel.text = String(format: "Cards: %d", self.source?.cards?.count ?? 0)
          self.cardsTableView.reloadData()
        }
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "openQuiz":
      let quizController = segue.destination as! QuizViewController
      quizController.source = source!
    default: break
    }
  }
}

extension SourceViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.source?.cards?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "card")
    let card = source!.cards![indexPath.row]
    
    cell.textLabel?.text = card.content
    cell.textLabel?.font = UIFont(name: "ArialRoundedMTBold", size: CGFloat(17))

    cell.detailTextLabel?.text = String(format: "%.0f%% correct.", Double(card.correctAnswersCount) / Double(card.answersCount) * 100.0)
    cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: CGFloat(12))
    cell.detailTextLabel?.textColor = UIColor.lightGray
    
    return cell
  }
}
