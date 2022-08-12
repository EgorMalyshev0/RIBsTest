//
//  LoginPresentableMock.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 12.08.2022.
//

import UIKit

final class LoginPresentableMock: LoginPresentable, LoginViewControllable {
    func present(_ viewController: UIViewController) {
        
    }
    
    var uiviewController: UIViewController = UIViewController()
    
    var listener: LoginPresentableListener?
    
    var indicatorCallCount: Int = 0
    
    func showActivityIndicator(_ isLoading: Bool) {
        indicatorCallCount += 1
    }
    
}
