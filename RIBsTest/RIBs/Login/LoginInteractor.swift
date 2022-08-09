//
//  LoginInteractor.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs
import RxSwift

protocol LoginRouting: ViewableRouting {
    func routeToCreateAccount()
    func detachCreateAccount()
    func showErrorAlert()
}

protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
    func showActivityIndicator(_ isLoading: Bool)
}

protocol LoginListener: AnyObject {
    func dismissLoginFlow()
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {

    weak var router: LoginRouting?
    weak var listener: LoginListener?
    
    private let webService: WebServicing

    init(presenter: LoginPresentable, webService: WebServicing) {
        self.webService = webService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func saveUserId(_ id: String) {
        UserDefaults.standard.set(id, forKey: "ribs_userid")
    }
    
    // MARK: - LoginPresentableListener
    func didTapLogin(username: String, password: String) {
        presenter.showActivityIndicator(true)
        webService.login(userName: username, password: password) { [weak self] result in
            self?.presenter.showActivityIndicator(false)
            switch result {
            case let .success(userID):
                self?.saveUserId(userID)
                self?.listener?.dismissLoginFlow()
            case let .failure(error):
                print(error.localizedDescription)
                self?.router?.showErrorAlert()
            }
        }
    }
    
    func didTapCreateAccount() {
        router?.routeToCreateAccount()
    }
    
    //MARK: - CreateAccountListener
    func createAccountDismissed() {
        router?.detachCreateAccount()
    }
    
    
}
