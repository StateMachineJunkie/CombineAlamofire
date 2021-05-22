//
//  JPToDo.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Foundation

public struct JPToDo: Codable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
