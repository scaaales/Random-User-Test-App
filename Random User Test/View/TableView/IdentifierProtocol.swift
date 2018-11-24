//
//  IdentifierProtocol.swift
//  Random User Test
//
//  Created by scales on 11/24/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import Foundation
import UIKit

protocol Identifierable {
	static var reuseIdentifier: String { get }
}

extension Identifierable where Self: UITableViewCell {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}
