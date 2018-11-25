//
//  UIImageView+extension.swift
//  Random User Test
//
//  Created by scales on 11/25/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

extension UIImageView {
	func makeRounded() {
		self.layer.cornerRadius = self.bounds.height / 2
		self.clipsToBounds = true
	}
}
