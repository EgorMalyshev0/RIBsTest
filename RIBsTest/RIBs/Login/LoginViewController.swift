//
//  LoginViewController.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs
import RxSwift
import UIKit

protocol LoginPresentableListener: AnyObject {
    func didTapLogin(username: String, password: String)
    func didTapCreateAccount()
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {
    
    weak var listener: LoginPresentableListener?

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func loginTapped(_ sender: Any) {
        listener?.didTapLogin(username: loginTextField.text!, password: passwordTextField.text!)
    }
    @IBAction func createAccountTapped(_ sender: Any) {
        listener?.didTapCreateAccount()
    }
    
    // MARK: - LoginPresentable
    func showActivityIndicator(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    // MARK: - LoginViewControllable
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
}
