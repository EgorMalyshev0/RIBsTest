//
//  RootInteractor.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToLogin()
    func routeToMain()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        isLoggedIn() ? router?.routeToMain() : router?.routeToLogin()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: "ribs_userid") != nil
    }
    
    // MARK: - LoginListener
    func dismissLoginFlow() {
        router?.routeToMain()
    }

    // MARK: - MainListener
    func dismissMainFlow() {
        router?.routeToLogin()
    }
}
