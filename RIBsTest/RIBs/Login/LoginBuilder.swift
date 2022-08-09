//
//  LoginBuilder.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs

protocol LoginDependency: CreateAccountDependency {
    var webService: WebServicing { get }
}

final class LoginComponent: Component<LoginDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoginBuildable: Buildable {
    func build(withListener listener: LoginListener) -> LoginRouting
}

final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoginListener) -> LoginRouting {
        let component = LoginComponent(dependency: dependency)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        let interactor = LoginInteractor(presenter: viewController, webService: component.dependency.webService)
        interactor.listener = listener
        let createAccountBuilder = CreateAccountBuilder(dependency: component.dependency)

        return LoginRouter(interactor: interactor, viewController: viewController, createAccountBuilder: createAccountBuilder)
    }
}
