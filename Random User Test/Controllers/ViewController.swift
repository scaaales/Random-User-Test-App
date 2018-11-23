//
//  ViewController.swift
//  Random User Test
//
//  Created by scales on 11/23/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var randomUserService: RandomUserService!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		randomUserService = RandomUserService()
		randomUserService.getUsers() { users in
			users.forEach { print($0) }
		}
	}


}

