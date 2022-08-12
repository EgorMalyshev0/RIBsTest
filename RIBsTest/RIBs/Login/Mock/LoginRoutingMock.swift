//
//  LoginRoutingMock.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 12.08.2022.
//

import Foundation
import RIBs

final class LoginRoutingMock: Router<LoginInteractable>, LoginRouting {
    
    var viewControllable: ViewControllable
    
    var showErrorAlertCallCount = 0
    
    init(interactor: LoginInteractable, viewControllable: ViewControllable) {
        self.viewControllable = viewControllable
        super.init(interactor: interactor)
    }
    
    func routeToCreateAccount() {
        
    }
    
    func detachCreateAccount() {
        
    }
    
    func showErrorAlert() {
        showErrorAlertCallCount += 1
    }
}
