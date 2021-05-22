//
//  JPComment.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

/// See documentation for `AlbumId`.
public struct CommentId: Codable, Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int
    public var rawValue: Int

    public init?(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct JPComment: Codable, Equatable, Identifiable {
    public let id: CommentId
    public let postId: PostId
    public let name: String
    public let email: MCEmailAddress
    public let body: String
}
