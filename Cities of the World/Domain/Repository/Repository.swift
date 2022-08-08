//
//  CityRepository.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation

class Repository {
	
	private let remoteDataSource: RemoteDataSource
	
	init(remoteDataSource: RemoteDataSource) {
		self.remoteDataSource = remoteDataSource
	}
	
	func fetchCitiesData(page: Int, completion: @escaping (Result<CityAPIResponse, ErrorModel>) -> Void) {
		let urlString = "?page=\(page)"
		remoteDataSource.fetch(relativeUrl: urlString, method: .get, type: CityAPIResponse.self, payload: nil, completionHandler: completion)
	}
	
	func filterCity(page: Int, cityName: String, completion: @escaping (Result<CityAPIResponse, ErrorModel>) -> Void) {
		let urlString = "?filter[0][name][contains]=\(cityName)&page=\(page)&include=country"
		remoteDataSource.fetch(relativeUrl: urlString, method: .get, type: CityAPIResponse.self, payload: nil, completionHandler: completion)
	}
	
}
