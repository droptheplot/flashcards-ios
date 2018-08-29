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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    authButton.layer.cornerRadius = 5
    errorLabel.isHidden = true
  }

  @IBAction func AuthButton(_ sender: UIButton) {
    repository.createToken(email: emailTextField.text!, password: passwordTextField.text!) { token, err in
      if err != nil {
        DispatchQueue.main.async {
          self.errorLabel.isHidden = false
        }
        
        return
      }
      
      Store.instance.token = token!

      DispatchQueue.main.async {
        self.errorLabel.isHidden = true
        self.performSegue(withIdentifier: "openSources", sender: nil)
      }
    }
  }
}
