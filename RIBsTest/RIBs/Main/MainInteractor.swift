//
//  MainInteractor.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs
import RxSwift

protocol MainRouting: ViewableRouting {
    func showItem(_ item: MainItem)
    func detachInfo()
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MainListener: AnyObject {
    func dismissMainFlow()
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MainPresentable) {
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
    
    private func cleanProfile() {
        UserDefaults.standard.removeObject(forKey: "ribs_userid")
    }
    
    // MARK: - MainPresentableListener
    func didTapLogOut() {
        cleanProfile()
        listener?.dismissMainFlow()
    }
    
    func didTapItem(_ item: MainItem) {
        router?.showItem(item)
    }
    
    // MARK: - InfoListener
    func infoDidPop() {
        router?.detachInfo()
    }
}
