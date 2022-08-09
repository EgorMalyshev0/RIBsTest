//
//  InfoBuilder.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs

protocol InfoDependency: Dependency {
}

final class InfoComponent: Component<InfoDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol InfoBuildable: Buildable {
    func build(withListener listener: InfoListener, item: MainItem) -> InfoRouting
}

final class InfoBuilder: Builder<InfoDependency>, InfoBuildable {

    override init(dependency: InfoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: InfoListener, item: MainItem) -> InfoRouting {
        let component = InfoComponent(dependency: dependency)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "InfoViewController") as! InfoViewController
        viewController.item = item
        let interactor = InfoInteractor(presenter: viewController)
        interactor.listener = listener
        return InfoRouter(interactor: interactor, viewController: viewController)
    }
}
