//
//  UserDescriptionViewController.swift
//  Random User Test
//
//  Created by scales on 11/24/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class UserDescriptionViewController: UIViewController {

	var user: User!
	
	@IBOutlet private weak var avatarImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var genderLabel: UILabel!
	@IBOutlet private weak var dateOfBirthLabel: UILabel!
	@IBOutlet private weak var locationLabel: UILabel!
	@IBOutlet private weak var phoneButton: UIButton!
	@IBOutlet private weak var cellphoneButton: UIButton!
	@IBOutlet private weak var emailButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupInterface()
    }
	
	private func setupInterface() {
		if let avenirNextFont = UIFont(name: "AvenirNext-Regular", size: 17) {
			navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: avenirNextFont], for: .normal)
		}
		
		if let avatarURL = URL(string: user.picture.large) {
			avatarImageView.af_setImage(withURL: avatarURL)
			avatarImageView.makeRounded()
		}
		
		nameLabel.text = user.fullName
		genderLabel.text = "Gender: " + user.gender.capitalized
		if let dateOfBirth = user.dateOfBirth {
			dateOfBirthLabel.text = "Date of birth: \(dateOfBirth) (\(user.age) y.o.)"
		} else {
			dateOfBirthLabel.text = "Unknown date of birth"
		}
		locationLabel.text = "📍 \(user.location.street) \(user.location.city), \(user.location.state)".capitalized
		
		phoneButton.setTitle("Phone number: " + user.phone, for: .normal)
		cellphoneButton.setTitle("Cellphone number: " + user.cell, for: .normal)
		emailButton.setTitle("E-mail: " + user.email, for: .normal)
	}
	
	private func makeCall(phoneNumber: String) {
		openURL(urlString: "tel://\(phoneNumber)")
	}
	
	private func openURL(urlString: String, onFail: (() -> Void)? = nil) {
		if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url)
		} else {
			onFail?()
		}
	}
	
	private func presentEmailConfirmationAlert(confirmationHandler: @escaping () -> Void) {
		let alertController = UIAlertController(title: "Do you want to send e-mail?", message: nil, preferredStyle: .alert)
		let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
			confirmationHandler()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		
		alertController.addAction(yesAction)
		alertController.addAction(cancelAction)
		present(alertController, animated: true)
	}
	
	@IBAction private func phoneTapped(_ sender: Any) {
		makeCall(phoneNumber: user.phone)
	}
	
	@IBAction func cellphoneTapped(_ sender: Any) {
		makeCall(phoneNumber: user.cell)
	}
	
	@IBAction func emailTapped(_ sender: Any) {
		presentEmailConfirmationAlert { [unowned self] in
			self.openURL(urlString: "mailto:\(self.user.email)") {
				let alertController = UIAlertController(title: "Wrong e-mail format", message: nil, preferredStyle: .alert)
				let okAction = UIAlertAction(title: "Ok", style: .cancel)
				
				alertController.addAction(okAction)
				self.present(alertController, animated: true)
			}
		}
	}
	
}
