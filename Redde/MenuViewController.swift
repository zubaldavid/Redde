//
//  MenuViewController.swift
//  Redde
//
//  Created by David Zubal on 1/5/19.
//  Copyright © 2019 David Zubal. All rights reserved.
//

import UIKit


class MenuViewController: UITabBarController {
    private let searchViewController: SearchViewController = {
        let vc = SearchViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        return vc
    }()

    private let metronomeViewController: MetronomeViewController = {
        let vc = MetronomeViewController()
        vc.tabBarItem = UITabBarItem(title: "Metronome", image: nil, selectedImage: nil)
        return vc
    }()

    private let settingsViewController: SettingsViewController = {
        let vc = SettingsViewController()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [searchViewController, metronomeViewController, settingsViewController]
    }
}
