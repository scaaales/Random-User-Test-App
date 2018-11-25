//
//  UsersViewController.swift
//  Random User Test
//
//  Created by scales on 11/23/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

	@IBOutlet private weak var tableView: UITableView!
	
	private var randomUserService: RandomUserService!
	private var users = [User]()
	
	private var isLoadingUsers = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		randomUserService = RandomUserService()
		loadUsers()
	}

	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = 100
	}
	
	private func loadUsers() {
		if isLoadingUsers { return }
		isLoadingUsers = true
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		randomUserService.getUsers() { [weak self] users in
			if let users = users {
				self?.users += users
			}
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
			self?.isLoadingUsers = false
			self?.tableView.reloadData()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let userDescriptionVC = segue.destination as? UserDescriptionViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
			userDescriptionVC.user = users[selectedRow]
		}
	}
	
}

extension UsersViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row == users.count - 1 {
			loadUsers()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension UsersViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return users.count
		} else {
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			guard let userCell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as? UserCell else { fatalError() }
			userCell.setup(with: users[indexPath.row])
			return userCell
		} else {
			guard let loaderCell = tableView.dequeueReusableCell(withIdentifier: LoaderCell.reuseIdentifier, for: indexPath) as? LoaderCell else { fatalError() }
			loaderCell.activityIndicator.startAnimating()
			return loaderCell
		}
	}
}


