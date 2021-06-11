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

/// User comment model.
public struct JPComment: Codable, Equatable, Identifiable {
    /// Unique identifier for this comment.
    public let id: CommentId
    /// Unique identifier for the associated `JPPost` value.
    public let postId: PostId
    /// I have no idea why comment needs a name. Check model reference in case of programmer error.
    public let name: String
    /// I have no idea why a comment needs an email address. Check model reference in case of programmer error.
    public let email: MCEmailAddress
    /// Comment body text.
    public let body: String
}
