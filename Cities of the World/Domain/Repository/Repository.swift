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
	
	func fetchCitiesData(payload: [String: Any], completion: @escaping (Result<CityAPIResponse, ErrorModel>) -> Void) {
		remoteDataSource.fetch(method: .get, type: CityAPIResponse.self, payload: nil, completionHandler: completion)
	}
	
	func filterCity(payload: [String: Any], completion: @escaping (Result<CityAPIResponse, ErrorModel>) -> Void) {
		remoteDataSource.fetch(method: .get, type: CityAPIResponse.self, payload: payload, completionHandler: completion)
	}
	
}
