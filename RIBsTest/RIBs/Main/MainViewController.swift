//
//  MainViewController.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs
import RxSwift
import UIKit

protocol MainPresentableListener: AnyObject {
    func didTapLogOut()
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Main"
    }
    
    @IBAction func didTapLogOut(_ sender: Any) {
        listener?.didTapLogOut()
    }
}
