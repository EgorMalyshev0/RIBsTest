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
    func routeToMain() -> MainActionableItem
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, RootActionableItem, URLHandler {

    weak var router: RootRouting?
    weak var listener: RootListener?
    
    private let mainActionableItemSubject = PublishSubject<MainActionableItem>()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if isLoggedIn() {
            routeToMain()
        } else {
            router?.routeToLogin()
        }
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: "ribs_userid") != nil
    }
    
    private func routeToMain() {
        let mainActionableItem = router?.routeToMain()
        if let mainActionableItem = mainActionableItem {
            mainActionableItemSubject.onNext(mainActionableItem)
        }
    }
    
    // MARK: - LoginListener
    func dismissLoginFlow() {
        routeToMain()
    }

    // MARK: - MainListener
    func dismissMainFlow() {
        router?.routeToLogin()
    }
    
    // MARK: - URLHandler
    func handle(_ url: URL) {
        let openInfoWorkflow = OpenInfoWorkflow(url: url)
            openInfoWorkflow
                .subscribe(self)
                .disposeOnDeactivate(interactor: self)
    }
    
    // MARK: - RootActionableItem
    func waitForLogin() -> Observable<(MainActionableItem, ())> {
        return mainActionableItemSubject
            .map { ($0, ())}
    }
    
}
