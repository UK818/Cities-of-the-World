////
////  RealmManager.swift
////  Cities of the World
////
////  Created by Usman.Kulaha on 05/08/2022.
////
//
//import Foundation
//import RealmSwift
//
//protocol RealmManagerDelegate {
//	func save<T: Object>(items: [T])
//	func reSave<T: Object>(items: [T])
//	func objects<T: Object>(_ type: T.Type) -> [T]
//	func objects<T: Object>() -> [T]
//	func getObjectById<T: Object>(type: T.Type, id: Int) -> T?
//	func clear<T: Object>(_ type: T.Type)
//	func clearAll()
//}
//
//class RealmManager: RealmManagerDelegate {
//	
//	//static let shared = RealmManager()
//	
//	fileprivate let realm = try! Realm()
//
//	
//	func save<T: Object>(items: [T]) {
//		try! realm.write {
//			realm.add(items, update: .modified)
//		}
//	}
//	
//	func reSave<T: Object>(items: [T]) {
//		clear(T.self)
//		try! realm.write {
//			realm.add(items, update: .modified)
//		}
//	}
//	
//	func objects<T: Object>(_ type: T.Type) -> [T] {
//		realm.objects(type).array
//	}
//	
//	func objects<T: Object>() -> [T] {
//		realm.objects(T.self).array
//	}
//	
//	func getObjectById<T: Object>(type: T.Type, id: Int) -> T? {
//		realm.object(ofType: type, forPrimaryKey: id)
//	}
//	
//	func clear<T: Object>(_ type: T.Type) {
//		try! realm.write {
//			let obj = realm.objects(type)
//			realm.delete(obj)
//		}
//	}
//	
//	func clearAll() {
//		try! realm.write {
//			realm.deleteAll()
//		}
//	}
//	
//}
//
//extension Results {
//	var array: [Element] { map { $0 } }
//}
//
//extension List {
//	var array: [Element] { map { $0 } }
//}
