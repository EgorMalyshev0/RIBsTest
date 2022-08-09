//
//  RootViewController.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
}

final class RootViewController: UINavigationController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    func present(_ viewController: ViewControllable) {
        setViewControllers([viewController.uiviewController], animated: false)
    }
    
}
