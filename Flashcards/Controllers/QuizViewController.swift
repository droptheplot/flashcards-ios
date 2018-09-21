//
//  QuizViewController.swift
//  Flashcards
//
//  Created by Sergei Novikov on 25/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit
import AVFoundation

class QuizViewController: BaseViewController {
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var pronounceButton: UIButton!
  
  let synthesizer = AVSpeechSynthesizer()
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
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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

    cardView.addGestureRecognizer(swipeLeft)
    cardView.addGestureRecognizer(swipeRight)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    cards = source!.cards?.makeIterator()

    currentCard = cards!.next()
    
    let padding = CGFloat(10)
    pronounceButton.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    pronounceButton.layer.cornerRadius = CGFloat(5)
    
    cardView.layer.cornerRadius = CGFloat(5)
    cardView.layer.masksToBounds = true
  }
  
  @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
    if gesture.direction == UISwipeGestureRecognizer.Direction.right {
      repository.addCardToUser(cardID: currentCard!.id, token: Store.instance.token!, correct: true) { _ in
        self.currentCard = self.cards!.next()
      }
      self.flash(self.successColor)
    } else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
      repository.addCardToUser(cardID: currentCard!.id, token: Store.instance.token!, correct: false) { _ in
        self.currentCard = self.cards!.next()
      }
      self.flash(self.baseColor)
    }
  }
  
  func flash(_ color: UIColor) {
    UIView.animate(withDuration: 1, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
      self.cardView.layer.backgroundColor = color.cgColor
    }, completion: nil)
    UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
      self.cardView.layer.backgroundColor = UIColor.white.cgColor
    }, completion: nil)
  }
  
  @IBAction func pronounce(_ sender: Any) {
    let utterance = AVSpeechUtterance(string: currentCard!.content)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    
    synthesizer.speak(utterance)
  }
}
