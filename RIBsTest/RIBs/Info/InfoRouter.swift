//
//  InfoRouter.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs

protocol InfoInteractable: Interactable {
    var router: InfoRouting? { get set }
    var listener: InfoListener? { get set }
}

protocol InfoViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class InfoRouter: ViewableRouter<InfoInteractable, InfoViewControllable>, InfoRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: InfoInteractable, viewController: InfoViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
