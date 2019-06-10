//
//  PlayerViewController.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 16/11/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // id
    // songTitleLabel
    // artistNameLabel
    // thumbnail
    // progressView
    var song: Song!
//    var songId: String!
    var songTitle: String!
    var artistName: String!
    
    // play
    // pause
    // fastforwards
    // rewind
    // next
    // previous

    override func viewDidLoad() {
        super.viewDidLoad()

        songTitle = song.title
        artistName = song.artistName
    }
    
}
