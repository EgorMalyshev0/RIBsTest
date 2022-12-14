//
//  MainBuilder.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs

protocol MainDependency: InfoDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> (router: MainRouting, actionableItem: MainActionableItem)
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> (router: MainRouting, actionableItem: MainActionableItem) {
        let component = MainComponent(dependency: dependency)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        let infoBuilder = InfoBuilder(dependency: component.dependency)
        let router = MainRouter(interactor: interactor, viewController: viewController, infoBuilder: infoBuilder)
        return (router, interactor)
    }
}
