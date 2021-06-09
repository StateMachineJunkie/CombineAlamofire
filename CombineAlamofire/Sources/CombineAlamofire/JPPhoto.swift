//
//  JPPhoto.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

/// See documentation for `AlbumId`.
public struct PhotoId: Codable, Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int
    public var rawValue: Int

    public init?(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct JPPhoto: Codable, Equatable, Identifiable {
    public let id: PhotoId
    public let albumId: AlbumId
    public let title: String
    public let url: URL
    public let thumbnailUrl: URL
}
