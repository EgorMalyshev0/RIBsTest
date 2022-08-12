//
//  WebService.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import Foundation

final class WebService: WebServicing {
    
    func login(userName: String, password: String, handler: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if userName == "admin" && password == "admin" {
                handler(.success("admin"))
            } else {
                handler(.failure(LoginError.invalidCredentials))
            }
        }
    }
 
}

enum LoginError: String, Error {
    case invalidCredentials = "Invalid credentials"
}
