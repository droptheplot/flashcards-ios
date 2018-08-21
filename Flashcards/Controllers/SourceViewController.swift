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
  
  var id: Int?
  var source: Source?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    sourceRepository.get(id: id!) { source in
      self.source = source
      
      DispatchQueue.main.async {
        self.sourceTitleLabel.text = self.source!.title
        self.sourceCardsCountLabel.text = String(format: "Cards: %d", self.source?.cards?.count ?? 0)
        self.cardsTableView.reloadData()
      }
    }
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
