//
//  SignupViewController.swift
//  LoginFlow
//
//  Created by Mustafa on 6/2/20.
//  Copyright © 2020 Mustafa Nafie. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var genderLabel: UILabel!
	@IBOutlet weak var genderSwitch: UISwitch!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		setup(textField: emailTextField)
		setup(textField: passwordTextField)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true) //This will hide the keyboard
	}

	@IBAction func signupButtonTapped(_ sender: Any) {
		saveData()
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func switchStateChanged(_ sender: Any) {
		if genderSwitch.isOn {
			genderLabel.text = "Male"
		} else {
			genderLabel.text = "Female"
		}
	}
}


// MARK: - TextField Delegate

extension SignupViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// Dismiss the keyboard when the user presses enter
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField == emailTextField {
			if !isValidEmail(email: textField.text!) {
				presentAlert(withTitle: "Invalid Email", message: "Check the entered email")
			}
		} else if textField == passwordTextField {
			if !isValidPassword(password: textField.text!) {
				presentAlert(withTitle: "Invalid Password", message: "Password must be minimum 8 characters at least 1 Capital Alphabet, 1 Number and 1 Special Character")
			}
		}
	}
	
}

// MARK: - Helper Functions

extension SignupViewController {
	
	private func saveData() {
		let user = User(email: emailTextField.text, password: passwordTextField.text, gender: genderSwitch.isOn, isLoggedIn: false)
		let data = try? JSONEncoder().encode(user)
		UserDefaults.standard.set(data, forKey: "user")
	}
	
	private func setup(textField: UITextField) {
		textField.delegate = self
	}
	
	private func isValidEmail(email: String) -> Bool {
		let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
	}
	
	private func isValidPassword(password: String) -> Bool {
		let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
		return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
	}
	
	private func presentAlert(withTitle title: String, message: String?) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let OKAction = UIAlertAction(title: "OK", style: .default)
		alertController.addAction(OKAction)
		present(alertController, animated: true, completion: nil)
	}
	
}

