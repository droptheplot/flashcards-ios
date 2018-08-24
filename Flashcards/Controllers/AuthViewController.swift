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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)

    super.viewWillDisappear(true)
  }
    
  override func viewDidAppear(_ animated: Bool) {
    authButton.layer.cornerRadius = 5
    errorLabel.isHidden = true

    super.viewDidAppear(animated)
  }

  @IBAction func AuthButton(_ sender: UIButton) {
    #if DEBUG
      self.token = ProcessInfo.processInfo.environment["DEBUG_TOKEN"]
      self.performSegue(withIdentifier: "openSources", sender: nil)
      return
    #endif
    
    tokenRepository.create(email: emailTextField.text!, password: passwordTextField.text!) { token, err in
      if err != nil {
        DispatchQueue.main.async {
          self.errorLabel.isHidden = false
        }
        
        return
      }
      
      self.token = token!

      DispatchQueue.main.async {
        self.errorLabel.isHidden = true
        self.performSegue(withIdentifier: "openSources", sender: nil)
      }
    }
  }
}
