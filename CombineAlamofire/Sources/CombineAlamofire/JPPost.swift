//
//  JPPost.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

/// See documentation for `AlbumId`.
public struct PostId: Codable, Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int
    public var rawValue: Int

    public init?(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct JPPost: Codable, Equatable, Identifiable {
    public let id: PostId
    public let userId: UserId
    public let title: String
    public let body: String
}
