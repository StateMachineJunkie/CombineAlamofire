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

public struct JPAlbum: Codable, Equatable, Identifiable {
    public let id: AlbumId
    public let userId: UserId
    public let title: String
}
