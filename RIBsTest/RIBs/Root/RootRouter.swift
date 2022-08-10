//
//  RootRouter.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs

protocol RootInteractable: Interactable, LoginListener, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(_ viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loginBuilder: LoginBuildable
    private let mainBuilder: MainBuildable
    private var loginRouter: LoginRouting?
    private var mainRouter: MainRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable, viewController: RootViewControllable, loginBuilder: LoginBuildable, mainBuilder: MainBuildable) {
        self.loginBuilder = loginBuilder
        self.mainBuilder = mainBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
//        routeToLogin()
    }
    
    func routeToLogin() {
        if let mainRouter = mainRouter {
            detachChild(mainRouter)
            self.mainRouter = nil
        }
        attachLogin()
    }
    
    @discardableResult
    func routeToMain() -> MainActionableItem {
        if let loginRouter = loginRouter {
            detachChild(loginRouter)
            self.loginRouter = nil
        }
        return attachMain()
    }
    
    private func attachLogin() {
        guard loginRouter == nil else { return }
        let router = loginBuilder.build(withListener: interactor)
        loginRouter = router
        attachChild(router)
        viewController.present(router.viewControllable)
    }
    
    private func attachMain() -> MainActionableItem {
        let result = mainBuilder.build(withListener: interactor)
        mainRouter = result.router
        attachChild(result.router)
        viewController.present(result.router.viewControllable)
        return result.actionableItem
    }

}
