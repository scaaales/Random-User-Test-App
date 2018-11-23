//
//  User.swift
//  Random User Test
//
//  Created by scales on 11/23/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import Foundation

struct User: Decodable {
	struct Name: Decodable {
		let title: String
		let first: String
		let last: String
	}
	
	struct Picture: Decodable {
		let large: String
	}
	
	private struct Dob: Decodable {
		let date: Date?
	}
	
	let gender: String
	let name: Name
	let email: String
	private let dob: Dob
	var dateOfBirth: String? {
		if let date = dob.date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "YYYY-MM-dd"
			return dateFormatter.string(from: date)
		}
		return nil
	}
	let phone: String
	let cell: String
	let picture: Picture
	
}

extension User: CustomStringConvertible {
	var description: String {
		return """
		User name = \(name.title) \(name.first) \(name.last)
		Gender = \(gender)
		Date of Birth = \(dateOfBirth ?? "unknown")
		---
		"""
	}
}
