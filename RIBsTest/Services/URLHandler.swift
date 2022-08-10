//
//  URLHandler.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 10.08.2022.
//

import Foundation

protocol URLHandler: AnyObject {
    func handle(_ url: URL)
}
