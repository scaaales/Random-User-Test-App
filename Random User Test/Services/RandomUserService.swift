//
//  RandomUserService.swift
//  Random User Test
//
//  Created by scales on 11/23/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import Alamofire

class RandomUserService {

	typealias CompletionHandler = ([User]) -> Void
	
	private let baseURL = "https://randomuser.me"
	private let apiPath = "/api"
	private let seed = "scales"
	
	private var requestCount = 0
	
	func getUsers(completion: @escaping CompletionHandler) {
		var urlComponents = URLComponents(string: baseURL)
		urlComponents?.path = apiPath
		urlComponents?.queryItems = generateQueryItems()
		
		guard let url = urlComponents?.url else { return }
		
		request(url).validate().responseJSON { [weak self] response in
			let jsonDecoder = JSONDecoder()
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
			
			jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
			
			if let data = response.data {
				do {
					let usersResult = try jsonDecoder.decode(UsersResult.self, from: data)
					self?.requestCount += 1
					completion(usersResult.results)
				} catch {
					print(error)
				}
			}
		}
	}
	
	private func generateQueryItems() -> [URLQueryItem] {
		let pageItem = URLQueryItem(name: "page", value: "\(requestCount)")
		let resultsItem = URLQueryItem(name: "results", value: "20")
		let seedItem = URLQueryItem(name: "seed", value: seed)
		return [pageItem, resultsItem, seedItem]
	}
	
}
