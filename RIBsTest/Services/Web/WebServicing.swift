//
//  WebServicing.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import Foundation

protocol WebServicing: AnyObject {
    func login(userName: String, password: String, handler: @escaping (Result<String, Error>) -> Void)
}
