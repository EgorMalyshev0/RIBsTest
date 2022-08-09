//
//  MainRouter.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs

protocol MainInteractable: Interactable, InfoListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    func push(_ viewController: ViewControllable)
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    
    private let infoBuilder: InfoBuildable
    private var infoRouter: InfoRouting?
    
    init(interactor: MainInteractable, viewController: MainViewControllable, infoBuilder: InfoBuildable) {
        self.infoBuilder = infoBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - MainRouting
    func showItem(_ item: MainItem) {
        guard infoRouter == nil else { return }
        let router = infoBuilder.build(withListener: interactor, item: item)
        infoRouter = router
        attachChild(router)
        viewController.push(router.viewControllable)
    }
    
    func detachInfo() {
        guard let infoRouter = infoRouter else { return }
        detachChild(infoRouter)
        self.infoRouter = nil
    }
}
