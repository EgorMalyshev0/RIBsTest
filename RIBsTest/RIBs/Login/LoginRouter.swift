//
//  LoginRouter.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs

protocol LoginInteractable: Interactable, CreateAccountListener {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
    func present(_ viewController: UIViewController)
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>, LoginRouting {
    
    private let createAccountBuilder: CreateAccountBuildable
    private var createAccountRouter: CreateAccountRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoginInteractable, viewController: LoginViewControllable, createAccountBuilder: CreateAccountBuildable) {
        self.createAccountBuilder = createAccountBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToCreateAccount() {
        guard createAccountRouter == nil else { return }
        
        let router = createAccountBuilder.build(withListener: interactor)
        createAccountRouter = router
        attachChild(router)
        viewController.present(router.viewControllable.uiviewController)
    }
    
    func detachCreateAccount() {
        guard let createAccountRouter = createAccountRouter else { return }
        detachChild(createAccountRouter)
        self.createAccountRouter = nil
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Incorrect login or password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        viewController.present(alert)
    }
}
