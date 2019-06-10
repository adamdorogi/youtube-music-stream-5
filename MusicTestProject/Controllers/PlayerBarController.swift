//
//  PlayerBarController.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 18/11/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit

class PlayerBarController: UITabBarController {
    
//    let playerBar = PlayerBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerBar = PlayerBar(frame: CGRect(x: 0,
                                                y: view.frame.height - tabBar.frame.height * 2,
                                                width: view.frame.width,
                                                height: tabBar.frame.height))
        
        view.addSubview(playerBar)
        tabBar.unselectedItemTintColor = .lightGray
    }

}
