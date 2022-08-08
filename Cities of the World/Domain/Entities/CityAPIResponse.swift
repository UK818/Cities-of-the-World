//
//  CityAPIResponse.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation

struct CityAPIResponse: Codable {
	let data: Cities
	let time: Int?
}

struct Cities: Codable {
	let items: [City]
	let pagination: Pagination
}

struct City: Codable {
	let id: Int?
	let name: String?
	let localName: String?
	let latitude: Double?
	let longitude: Double?
	let createdAt: String = "2018-01-07 17:08:01"
	let updatedAt: String = "2018-04-12 21:37:25"
	let countryId: Int?
	
	enum CodingKeys: String, CodingKey {
		case id, name
		case localName = "local_name"
		case latitude = "lat"
		case longitude = "lng"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case countryId = "country_id"
	}
}

struct Pagination: Codable {
	let currentPage, lastPage, perPage, total: Int?
	
	enum CodingKeys: String, CodingKey {
		case currentPage = "current_page"
		case lastPage = "last_page"
		case perPage = "per_page"
		case total
	}
}

struct ErrorModel: Codable, Error {
	let message: String?
}
