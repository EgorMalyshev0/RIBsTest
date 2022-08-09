//
//  MainItem.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import Foundation

enum MainItem: String, CaseIterable {
    case first = "First"
    case second = "Second"
    case third = "Third"
    
    var description: String {
        switch self {
        case .first:
            return "This is first item"
        case .second:
            return "This is second item"
        case .third:
            return "This is third item"
        }
    }
}
