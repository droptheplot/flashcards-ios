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
  @IBOutlet weak var stateButton: UIButton!
  
  enum State {
    case signIn()
    case signUp()
  }
  
  var state: State = .signIn() {
    didSet {
      switch state {
      case .signUp():
        errorLabel.isHidden = true
        authButton.setTitle("SIGN UP", for: [])
        stateButton.setTitle("I already have an account", for: [])
      case .signIn():
        errorLabel.isHidden = true
        authButton.setTitle("SIGN IN", for: [])
        stateButton.setTitle("I don't have an account", for: [])
      }
    }
  }
  
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

  @IBAction func stateButton(_ sender: UIButton) {
    switch state {
    case .signIn():
      state = .signUp()
    case .signUp():
      state = .signIn()
    }
  }
  
  @IBAction func authButton(_ sender: UIButton) {
    switch state {
    case .signIn():
      signIn()
    case .signUp():
      signUp()
    }
  }
  
  private func signIn() {
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
  
  private func signUp() {
    let email = emailTextField.text!
    let password = passwordTextField.text!
    
    repository.createUser(email: email, password: password) { result in
      switch result {
      case .failure(_):
        DispatchQueue.main.async {
          self.errorLabel.isHidden = false
        }
      case .success():
        self.repository.createToken(email: email, password: password) { result in
          switch result {
          case .success(let token):
            Store.instance.token = token
            
            DispatchQueue.main.async {
              self.errorLabel.isHidden = true
              self.performSegue(withIdentifier: "openSources", sender: nil)
            }
          case .failure(_): break
          }
        }
      }
    }
  }
}
