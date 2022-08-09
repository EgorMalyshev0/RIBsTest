//
//  MainViewController.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs
import RxSwift
import UIKit

protocol MainPresentableListener: AnyObject {
    func didTapLogOut()
    func didTapItem(_ item: MainItem)
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {
    
    private let items = MainItem.allCases

    weak var listener: MainPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Main"
    }
    
    @IBAction func didTapLogOut(_ sender: Any) {
        listener?.didTapLogOut()
    }
    
    // MARK: - MainViewControllable
    func push(_ viewController: ViewControllable) {
        navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Main", for: indexPath) as! MainTableViewCell
        cell.setup(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didTapItem(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
