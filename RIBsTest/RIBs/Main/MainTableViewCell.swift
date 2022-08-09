//
//  MainTableViewCell.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 09.08.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    func setup(with item: MainItem) {
        textLabel?.text = item.rawValue
    }

}
