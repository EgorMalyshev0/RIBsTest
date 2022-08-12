//
//  LoginListenerMock.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 12.08.2022.
//

import Foundation

final class LoginListenerMock: LoginListener {
    
    var dismissedCallCount = 0
    
    func dismissLoginFlow() {
        dismissedCallCount += 1
    }
    
}
