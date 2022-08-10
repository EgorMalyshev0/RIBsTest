//
//  RootBuilder.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs
import RxSwift

protocol RootDependency: LoginDependency, MainDependency {}

final class RootComponent: Component<RootDependency> {

    private let rootViewController: RootViewController
    
    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

final class AppComponent: Component<EmptyDependency>, RootDependency {
    let webService: WebServicing
    
    init(webService: WebServicing) {
        self.webService = webService
        super.init(dependency: EmptyComponent())
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> (router: LaunchRouting, urlHandler: URLHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> (router: LaunchRouting, urlHandler: URLHandler) {
        let viewController = RootViewController()
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        
        let interactor = RootInteractor(presenter: viewController)
        let router = RootRouter(
            interactor: interactor,
            viewController: viewController,
            loginBuilder: LoginBuilder(dependency: component.dependency), mainBuilder: MainBuilder(dependency: component.dependency)
        )
        return (router, interactor)
    }
}
