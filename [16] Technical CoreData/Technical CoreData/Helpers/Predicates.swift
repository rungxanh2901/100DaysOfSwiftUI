//
//  Predicates.swift
//  Technical CoreData
//
//  Created by Joe Pham on 2022-08-28.
//

import Foundation

enum Predicates {
	/// Aids `FilteredList` in filtering a fetch request based on its cases
	internal enum Types: CaseIterable {
		case contains
		case beginsWith
		case notBeginsWith
	}
	
	static let shipNamesNotStartsWithD: NSPredicate = Predicates.notBeginsWith(key: "name", value: "D")
	static let shipsInSomeUniverses: NSPredicate = Predicates.inValues(key: "universe", values: ["Aliens", "Firefly", "Star Trek"])

	
	static func contains(key: String, value: String) -> NSPredicate {
		NSPredicate(format: "%K CONTAINS[cd] %@", key, value)
	}
	
	static func beginsWith(key: String, value: String) -> NSPredicate {
		NSPredicate(format: "%K BEGINSWITH[cd] %@", key, value)
	}
	
	static func notBeginsWith(key: String, value: String) -> NSPredicate {
		NSPredicate(format: "NOT %K BEGINSWITH[cd] %@", key, value)
	}
	
	static func inValues(key: String, values: [String]) -> NSPredicate {
		NSPredicate(format: "%K IN %@", key, values)
	}
}
