//
//  ProfileViewController.swift
//  LoginFlow
//
//  Created by Mustafa on 7/2/20.
//  Copyright © 2020 Mustafa Nafie. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	@IBOutlet weak var welcomeLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		displayUserInfo()
	}

	@IBAction func signOutButtonTapped(_ sender: Any) {
		signOutUser()
		goToLoginScreen()
	}
}

// MARK: - Helper Functions

extension ProfileViewController {
	
	private func goToLoginScreen() {
		let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
		loginVC!.modalPresentationStyle = .fullScreen
		present(loginVC!, animated: true, completion: nil)
	}
	
	private func displayUserInfo() {
		guard let data = UserDefaults.standard.data(forKey: "user") else { return }
		let user = try? JSONDecoder().decode(User.self, from: data)
		welcomeLabel.text = "Welcome " + (user?.email)!
	}
	
	private func signOutUser() {
		// Get user data from user defaults
		guard let data = UserDefaults.standard.data(forKey: "user") else { return }
		// Set isLoggedIn to false
		var user = try? JSONDecoder().decode(User.self, from: data)
		user?.isLoggedIn = false
		// Save data
		let updatedData = try? JSONEncoder().encode(user)
		UserDefaults.standard.set(updatedData, forKey: "user")
	}
	
}

