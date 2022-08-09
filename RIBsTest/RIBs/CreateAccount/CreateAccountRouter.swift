//
//  CreateAccountRouter.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import RIBs

protocol CreateAccountInteractable: Interactable {
    var router: CreateAccountRouting? { get set }
    var listener: CreateAccountListener? { get set }
}

protocol CreateAccountViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class CreateAccountRouter: ViewableRouter<CreateAccountInteractable, CreateAccountViewControllable>, CreateAccountRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CreateAccountInteractable, viewController: CreateAccountViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
