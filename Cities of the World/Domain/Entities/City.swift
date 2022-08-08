//
//  City.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation
import RealmSwift

class CityModel: Object {
	@Persisted var id: Int
	@Persisted var name: String
	@Persisted var localName: String
	@Persisted var latitude: Double
	@Persisted var longitude: Double
	
	convenience init(id: Int, name: String, localName: String, latitude: Double, longitude: Double) {
		self.init()
		self.id = id
		self.name = name
		self.localName = localName
		self.latitude = latitude
		self.longitude = longitude
	}
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
