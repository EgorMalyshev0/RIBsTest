//
//  InfoViewController.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import RIBs
import RxSwift
import UIKit

protocol InfoPresentableListener: AnyObject {
    func didDisappear()
}

final class InfoViewController: UIViewController, InfoPresentable, InfoViewControllable {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var listener: InfoPresentableListener?
    var item: MainItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = item?.rawValue
        descriptionLabel.text = item?.description
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.didDisappear()
    }

}
