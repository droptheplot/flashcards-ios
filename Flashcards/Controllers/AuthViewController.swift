//
//  AuthViewController.swift
//  Flashcards
//
//  Created by Sergei Novikov on 21/08/2018.
//  Copyright © 2018 Sergei Novikov. All rights reserved.
//

import UIKit

class AuthViewController: BaseViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var authButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var authButtonTopConstraint: NSLayoutConstraint!
  
  override func viewWillAppear(_ animated: Bool) {
    authButton.layer.cornerRadius = 5
    errorLabel.isHidden = true
    
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if Store.instance.token != nil {
      DispatchQueue.main.async {
        self.performSegue(withIdentifier: "openSources", sender: nil)
      }
    }
  }

  @IBAction func AuthButton(_ sender: UIButton) {
    repository.createToken(email: emailTextField.text!, password: passwordTextField.text!) { result in
      switch result {
      case .failure(_):
        DispatchQueue.main.async {
          self.errorLabel.isHidden = false
        }
      case .success(let token):
        Store.instance.token = token
        
        DispatchQueue.main.async {
          self.errorLabel.isHidden = true
          self.performSegue(withIdentifier: "openSources", sender: nil)
        }
      }
    }
  }
}
