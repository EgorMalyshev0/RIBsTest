//
//  MockWebService.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 12.08.2022.
//

import Foundation

class MockWebService: WebServicing {
    init() { }

    var loginCallCount = 0
    var loginHandler: ((String, String, (Result<String, Error>) -> Void) -> ())?
    func login(userName username: String, password: String, handler: (Result<String, Error>) -> Void)  {
        loginCallCount += 1
        if let loginHandler = loginHandler {
            loginHandler(username, password, handler)
        }
        
    }
}
