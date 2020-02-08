//
//  SignupViewController.swift
//  LoginFlow
//
//  Created by Mustafa on 6/2/20.
//  Copyright © 2020 Mustafa Nafie. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
	
	@IBOutlet weak var emailTextField: UITextField! {
		didSet { setup(textField: emailTextField) }
	}
	
	@IBOutlet weak var passwordTextField: UITextField! {
		didSet { setup(textField: passwordTextField) }
	}
	
	@IBOutlet weak var genderLabel: UILabel!
	@IBOutlet weak var genderSwitch: UISwitch!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

// MARK: - Helper Functions

extension SignupViewController {
	
	private func saveData() {
		let defaults = UserDefaults.standard
		defaults.set(true, forKey: "isLoggedin")
		defaults.set(emailTextField.text, forKey: "Email")
		defaults.set(passwordTextField.text, forKey: "Password")
		defaults.set(genderLabel.text, forKey: "Gender")
	}
	
	private func setup(textField: UITextField) {
		textField.delegate = self
	}
	
}

// MARK: - TextField Delegate

extension SignupViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// Dismiss the keyboard when the user presses enter
		textField.resignFirstResponder()
		return true
	}
	
}
