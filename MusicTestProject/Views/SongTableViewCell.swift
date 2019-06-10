//
//  SongTableViewCell.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 29/9/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set background color.
        backgroundColor = .tableCell
        
        // Set height.
        frame.size.height = CellDimensions.Song.height
        
        // Set up title label.
        titleLabel.textColor = .white
        titleLabel.font = titleLabel.font.withSize(16)
        
        // Set up artist label.
        artistLabel.textColor = .gray
        artistLabel.font = artistLabel.font.withSize(12)
        
        // Set up selected background view.
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        selectedBackgroundView = backgroundView
        
        // Add labels to cell.
        contentView.addSubview(titleLabel)
        contentView.addSubview(artistLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout title label.
        titleLabel.frame.size = CGSize(width: frame.width - 2 * CellDimensions.Song.horizontalMargin,
                                       height: CellDimensions.Song.height / 3)
        titleLabel.frame.origin = CGPoint(x: CellDimensions.Song.horizontalMargin,
                                          y: CellDimensions.Song.height / 2 - titleLabel.frame.height)
        
        // Layout artist label.
        artistLabel.frame.size = titleLabel.frame.size
        artistLabel.frame.origin = CGPoint(x: CellDimensions.Song.horizontalMargin,
                                           y: CellDimensions.Song.height / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
