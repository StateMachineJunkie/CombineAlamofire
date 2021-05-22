//
//  JPComment.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPComment: Codable, Equatable, Identifiable {
    public let id: Int
    let postId: Int
    let name: String
    let email: MCEmailAddress
    let body: String
}
