//
//  StorageProvider.swift
//  Socialie
//
//  Created by Joe Pham on 2022-09-02.
//

import CoreData

protocol StorageProvider {
	var context: NSManagedObjectContext { get }
	func fetch<T>() -> T
	func saveAndHandleError() -> Void
}

/// Implementation of a `StorageProvider` for `CachedUser`
final class StorageProviderImpl: StorageProvider {
	
	/// Singleton instance to use in the app
	static let standard: StorageProviderImpl = .init()
	
	private let container: NSPersistentContainer
	let context: NSManagedObjectContext
	
	private init() {
		container = .init(name: Constants.Persistence.dataModelName)
		container.loadPersistentStores { (_, error) in
			if let error = error {
				fatalError("Core Data failed to load: \(error.localizedDescription)")
			}
		}
		context = container.viewContext
		// Merge added entity instances by unique constraints
		context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
	}
	
	/// Returrns a sorted array of fetched `CachedUser`
	func fetch<T>() -> T {
		let fetchRequest: NSFetchRequest<CachedUser> = CachedUser.fetchRequest()
		// Sort fetch results by name
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(keyPath: \CachedUser.name, ascending: true)
		]
		return loadAndHandleError(from: fetchRequest) as! T
	}
	
	fileprivate func loadAndHandleError(from request: NSFetchRequest<CachedUser>) -> [CachedUser] {
		do {
			return try context.fetch(request)
		} catch let error {
			print("Error fetching cached users. \(error.localizedDescription)")
			return [CachedUser]()
		}
	}
	
	func saveAndHandleError() -> Void {
		do {
			if context.hasChanges {
				try context.save()
			}
		} catch let error {
			print("Error saving data. \(error.localizedDescription)")
		}
	}
}
