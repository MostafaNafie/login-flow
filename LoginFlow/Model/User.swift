//
//  User.swift
//  LoginFlow
//
//  Created by Mustafa on 12/2/20.
//  Copyright © 2020 Mustafa Nafie. All rights reserved.
//

import Foundation

struct User: Codable {
	var email: String!
	var password: String!
	var gender: Bool!
	var isLoggedIn: Bool!
}
