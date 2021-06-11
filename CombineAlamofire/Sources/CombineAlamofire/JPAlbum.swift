//
//  JPAlbum.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

/// Albums are identified with a common integer type. This is sufficient for
/// making them conform to the `Identifiable` protocol but we don't want those
/// IDs to be interchangeable with other integer based identifiable entities.
/// This type will prevent that from occurring.
public struct AlbumId: Codable, Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int
    public var rawValue: Int

    public init?(rawValue: Int) {
        self.rawValue = rawValue
    }
}

/// Photo album model.
public struct JPAlbum: Codable, Equatable, Identifiable {
    /// Unique identifier.
    public let id: AlbumId
    /// Unique identifier of the user owning this album value.
    public let userId: UserId
    /// Title for this album value.
    public let title: String
}
