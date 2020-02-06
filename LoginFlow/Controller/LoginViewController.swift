//
//  LoginViewController.swift
//  LoginFlow
//
//  Created by Mustafa on 6/2/20.
//  Copyright © 2020 Mustafa Nafie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var signupButton: UIButton!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func signupButtonTapped(_ sender: Any) {
		goToSignupScreen()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true) //This will hide the keyboard
	}
	
}

extension LoginViewController {
	private func goToSignupScreen() {
		let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
		signupVC.modalPresentationStyle = .fullScreen
		present(signupVC, animated: true, completion: nil)
	}
}

// MARK: - TextField Delegate

extension LoginViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// Dismiss the keyboard when the user presses enter
		textField.resignFirstResponder()
		return true
	}
	
}

