//
//  JPToDo.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPToDo: Codable, Equatable, Identifiable {
    public let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}
