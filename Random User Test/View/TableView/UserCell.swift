//
//  UserCell.swift
//  Random User Test
//
//  Created by scales on 11/24/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit
import AlamofireImage

class UserCell: UITableViewCell, Identifierable {

	@IBOutlet private weak var profileImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var ageLabel: UILabel!
	@IBOutlet private weak var locationLabel: UILabel!
	
	func setup(with user: User) {
		if let imageURL = URL(string: user.picture.large) {
			profileImageView.af_setImage(withURL: imageURL)
			profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
			profileImageView.clipsToBounds = false
		}
		nameLabel.text = user.fullName
		ageLabel.text = "\(user.age) year's old"
		locationLabel.text = "📍 \(user.location.city), \(user.location.state)".capitalized
	}
	
}
