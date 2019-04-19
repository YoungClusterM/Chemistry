//
//  CustomTabBarController.swift
//  Chemistry
//
//  Created by Паша Косило on 3/17/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    func setTitle() {
        if let newTitle = self.selectedViewController?.title {
            self.navigationItem.title = newTitle
            if let newSearch = self.selectedViewController?.navigationItem.searchController {
                self.navigationItem.hidesSearchBarWhenScrolling = true
                self.navigationItem.searchController = newSearch
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setTitle()
    }
    
    override var selectedViewController: UIViewController? {
        didSet {
            setTitle()
        }
    }
}
