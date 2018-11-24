//
//  User.swift
//  Random User Test
//
//  Created by scales on 11/23/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import Foundation

struct User: Decodable {
	private struct Name: Decodable {
		let first: String
		let last: String
	}
	
	struct Location: Decodable {
		let street: String
		let city: String
		let state: String
	}
	
	struct Picture: Decodable {
		let large: String
	}
	
	private struct Dob: Decodable {
		let date: String
		let age: Int
	}
	
	let gender: String
	
	let location: Location
	
	private let name: Name
	var fullName: String {
		return "\(name.first) \(name.last)".capitalized
	}
	let email: String
	
	private let dob: Dob
	var dateOfBirth: String? {
		return dob.date.components(separatedBy: "T").first
	}
	var age: Int {
		return dob.age
	}
	
	let phone: String
	let cell: String
	let picture: Picture
	
}

