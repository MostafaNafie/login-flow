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
	
	@IBOutlet weak var emailTextField: UITextField! {
		didSet { setup(textField: emailTextField) }
	}
	
	@IBOutlet weak var passwordTextField: UITextField! {
		didSet { setup(textField: passwordTextField) }
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func loginButtonTapped(_ sender: Any) {
		if isDataValid() {
			print("Valid Data")
			let defaults = UserDefaults.standard
			defaults.set(true, forKey: "isLoggedin")
			dismiss(animated: true, completion: nil)

//			let appDelegate = SceneDelegate()

//			let storyboard = UIStoryboard(name: "Main", bundle: nil)
//			let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//			self.parent?.addChild(profileVC)
//			self.removeFromParent()
			goToProfileScreen()

//			appDelegate.window?.rootViewController = profileVC
//			appDelegate.window?.makeKeyAndVisible()
		}
	}
	
	@IBAction func signupButtonTapped(_ sender: Any) {
		goToSignupScreen()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true) //This will hide the keyboard
	}
	
}

// MARK: - Helper Functions

extension LoginViewController {
	
	private func goToSignupScreen() {
		let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
		signupVC.modalPresentationStyle = .fullScreen
		present(signupVC, animated: true, completion: nil)
	}
	
	private func goToProfileScreen() {
		let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
		profileVC.modalPresentationStyle = .fullScreen
		present(profileVC, animated: true, completion: nil)
	}
	
	private func isDataValid() -> Bool {
		let defaults = UserDefaults.standard
		if emailTextField.text != defaults.string(forKey: "Email") {
			print("Wrong Email")
			return false
		}
		if passwordTextField.text != defaults.string(forKey: "Password") {
			print("Wrong Password")
			return false
		}
		return true
	}
	
	private func setup(textField: UITextField) {
		textField.delegate = self
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

