//
//  CreateAccountViewController.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs
import RxSwift
import UIKit

protocol CreateAccountPresentableListener: AnyObject {
    func didDisappear()
}

final class CreateAccountViewController: UIViewController, CreateAccountPresentable, CreateAccountViewControllable {

    weak var listener: CreateAccountPresentableListener?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.didDisappear()
    }
}
