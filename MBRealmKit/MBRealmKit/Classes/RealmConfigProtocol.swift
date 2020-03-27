//
//  Copyright © 2019 MBition GmbH. All rights reserved.
//

import Foundation
import RealmSwift

/// Protocol to configure realm
public protocol RealmConfigProtocol {
	
	var deleteRealmIfMigrationNeeded: Bool { get }
	var encryptionKey: Data? { get }
	var filename: String { get }
	var filesizeToCompact: Int? { get }
	var inMemoryIdentifier: String? { get }
	var migrationBlock: MigrationBlock? { get }
	var objects: [Object.Type]? { get }
	var readOnly: Bool { get }
	var schemaVersion: UInt64 { get }
}

public extension RealmConfigProtocol {
	
	var realm: Realm? {
		
		let fileURL = self.realmFilename.isEmpty ?
			Realm.Configuration.defaultConfiguration.fileURL :
			Realm.Configuration.defaultConfiguration.fileURL?.deletingLastPathComponent().appendingPathComponent(self.realmFilename)
		
//		let filesizeToCompact = self.filesizeToCompact ?? 0
//		let shouldCompactOnLaunch: ((Int, Int) -> Bool)? = (filesizeToCompact == 0) ? nil : { (totalBytes, usedBytes) -> Bool in
//
//			let fileSize = filesizeToCompact * 1024 * 1024
//			return (totalBytes > fileSize) && (Double(usedBytes) / Double(totalBytes)) < 0.5
//		}
		
		let configuration = Realm.Configuration(fileURL: fileURL,
												inMemoryIdentifier: self.inMemoryIdentifier,
//												syncConfiguration: <#T##SyncConfiguration?#>,
												encryptionKey: self.encryptionKey,
												readOnly: self.readOnly,
												schemaVersion: self.schemaVersion,
												migrationBlock: self.migrationBlock,
												deleteRealmIfMigrationNeeded: self.deleteRealmIfMigrationNeeded,
												shouldCompactOnLaunch: self.compactClosure, // shouldCompactOnLaunch,
												objectTypes: self.objects)
		
		return try? Realm(configuration: configuration)
	}
	
	var realmFilename: String {
		return self.filename.isEmpty ? "" : (self.filename.contains(".realm") ? self.filename : self.filename + ".realm")
	}
}

private extension RealmConfigProtocol {
	
	var compactClosure: ((Int, Int) -> Bool)? {
		
		guard let filesizeToCompact = self.filesizeToCompact else {
			return nil
		}
		
		return { (totalBytes, usedBytes) -> Bool in
			
			let fileSize = filesizeToCompact * 1024 * 1024
			return (totalBytes > fileSize) && (Double(usedBytes) / Double(totalBytes)) < 0.5
		}
	}
}
