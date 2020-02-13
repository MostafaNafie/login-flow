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

		setup(textField: emailTextField)
		setup(textField: passwordTextField)
	}

	@IBAction func loginButtonTapped(_ sender: Any) {
		if isDataValid() {
			print("Valid Data")
			loginUser()
			dismiss(animated: true, completion: nil)
			goToProfileScreen()
		}
	}
	
	@IBAction func signupButtonTapped(_ sender: Any) {
		goToSignupScreen()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true) //This will hide the keyboard
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

// MARK: - Helper Functions

extension LoginViewController {
	
	private func goToSignupScreen() {
		let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupViewController")
		signupVC!.modalPresentationStyle = .fullScreen
		present(signupVC!, animated: true, completion: nil)
	}
	
	private func goToProfileScreen() {
		let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
		profileVC!.modalPresentationStyle = .fullScreen
		present(profileVC!, animated: true, completion: nil)
	}
	
	private func isDataValid() -> Bool {

		guard !emailTextField.text!.isEmpty else {
			presentAlert(withTitle: "No Email", message: "Please enter your email")
			return false
		}
		
		guard !passwordTextField.text!.isEmpty else {
			presentAlert(withTitle: "No Password", message: "Please enter your password")
			return false
		}
		
		guard let data = UserDefaults.standard.data(forKey: "user") else { return false }
		print("User is Found")
		let user = try? JSONDecoder().decode(User.self, from: data)
		
		if emailTextField.text != user?.email {
			print("Wrong Email")
			presentAlert(withTitle: "Wrong Email", message: "Please check your email")
			return false
		}
		
		if passwordTextField.text != user?.password {
			print("Wrong Password")
			presentAlert(withTitle: "Wrong Password", message: "Please check your password")
			return false
		}
		
		return true
	}
	
	private func setup(textField: UITextField) {
		textField.delegate = self
	}
	
	private func presentAlert(withTitle title: String, message: String?) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let OKAction = UIAlertAction(title: "OK", style: .default)
		alertController.addAction(OKAction)
		present(alertController, animated: true, completion: nil)
	}
	
	private func loginUser() {
		// Get user data from user defaults
		guard let data = UserDefaults.standard.data(forKey: "user") else { return }
		// Set isLoggedIn to true
		var user = try? JSONDecoder().decode(User.self, from: data)
		user?.isLoggedIn = true
		// Save data
		let updatedData = try? JSONEncoder().encode(user)
		UserDefaults.standard.set(updatedData, forKey: "user")
	}
	
}

