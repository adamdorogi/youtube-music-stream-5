//
//  PlayerBar.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 20/11/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit

class PlayerBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set blur effect.
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        // Add bottom line.
        let layer2 = CALayer()
        layer2.backgroundColor = UIColor.darkGray.cgColor
        layer2.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 0.1)
        
        layer.addSublayer(layer2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
