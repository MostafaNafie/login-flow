//
//  ProfileViewController.swift
//  LoginFlow
//
//  Created by Mustafa on 7/2/20.
//  Copyright © 2020 Mustafa Nafie. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	@IBOutlet weak var welcomeLabel: UILabel! {
		didSet { welcomeLabel.text = UserDefaults.standard.string(forKey: "Email") }
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func signOutButtonTapped(_ sender: Any) {
		UserDefaults.standard.set(false, forKey: "isLoggedin")
		dismiss(animated: true, completion: nil)
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
	
}

