//
//  QuizViewController.swift
//  Flashcards
//
//  Created by Sergei Novikov on 25/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit

class QuizViewController: BaseViewController {
  @IBOutlet weak var contentLabel: UILabel!

  var source: Source?
  var cards: IndexingIterator<[Card]>?
  var currentCard: Card? {
    didSet {
      if currentCard != nil {
        DispatchQueue.main.async {
          self.contentLabel.text = self.currentCard!.content
        }
        return
      }
      
      DispatchQueue.main.async {
        self.navigationController?.popViewController(animated: true)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))

    swipeLeft.direction = .left
    swipeRight.direction = .right

    self.view.addGestureRecognizer(swipeLeft)
    self.view.addGestureRecognizer(swipeRight)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.title = source!.title
    cards = source!.cards?.makeIterator()

    currentCard = cards!.next()
  }
  
  @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
    if gesture.direction == UISwipeGestureRecognizerDirection.right {
      repository.addCardToUser(cardID: currentCard!.id, token: Store.instance.token!, correct: true) { _ in
        self.currentCard = self.cards!.next()
      }
    } else if gesture.direction == UISwipeGestureRecognizerDirection.left {
      repository.addCardToUser(cardID: currentCard!.id, token: Store.instance.token!, correct: false) { _ in
        self.currentCard = self.cards!.next()
      }
    }
  }
}
