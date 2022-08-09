//
//  InfoInteractor.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs
import RxSwift

protocol InfoRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol InfoPresentable: Presentable {
    var listener: InfoPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol InfoListener: AnyObject {
    func infoDidPop()
}

final class InfoInteractor: PresentableInteractor<InfoPresentable>, InfoInteractable, InfoPresentableListener {

    weak var router: InfoRouting?
    weak var listener: InfoListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: InfoPresentable) {
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
    
    // MARK: - InfoPresentableListener
    func didDisappear() {
        listener?.infoDidPop()
    }
}
