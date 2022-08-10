//
//  OpenInfoWorkflow.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 10.08.2022.
//

import RxSwift
import RIBs

protocol RootActionableItem: AnyObject {
    func waitForLogin() -> Observable<(MainActionableItem, ())>
}

protocol MainActionableItem: AnyObject {
    func openInfo(with item: MainItem?) -> Observable<(MainActionableItem, ())>
}

class OpenInfoWorkflow: Workflow<RootActionableItem> {
    public init(url: URL) {
        super.init()

        let item = parseItem(from: url)

        self
            .onStep { (rootItem: RootActionableItem) -> Observable<(MainActionableItem, ())> in
                rootItem.waitForLogin()
            }
            .onStep { (mainItem: MainActionableItem, _) -> Observable<(MainActionableItem, ())> in
                mainItem.openInfo(with: item)
            }
            .commit()
    }

    private func parseItem(from url: URL) -> MainItem? {
        let components = URLComponents(string: url.absoluteString)
        let items = components?.queryItems ?? []
        for item in items {
            if item.name == "itemName" {
                return MainItem(rawValue: item.value ?? "")
            }
        }
        return nil
    }
}
