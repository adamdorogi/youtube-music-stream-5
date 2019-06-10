//
//  ArtistTableViewCell.swift
//  MusicTestProject
//
//  Created by Adam Dorogi-Kaposi on 1/10/17.
//  Copyright © 2017 Adam Dorogi-Kaposi. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var profileImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set profile image view background color.
        profileImageView.backgroundColor = .background
        
        // Set background color.
        backgroundColor = .tableCell
        
        // Set height.
        frame.size.height = CellDimensions.Artist.height
        
        // Set up title label.
        nameLabel.textColor = .white
        nameLabel.font = nameLabel.font.withSize(16)
        
        // Set up selected background view.
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        selectedBackgroundView = backgroundView
        
        // Add label and image view to cell.
        contentView.addSubview(nameLabel)
        contentView.addSubview(profileImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout image view.
        let profileImageViewSize = frame.height - 2 * CellDimensions.Artist.verticalMargin
        
        profileImageView.frame.size = CGSize(width: profileImageViewSize,
                                             height: profileImageViewSize)
        profileImageView.frame.origin = CGPoint(x: CellDimensions.Artist.horizontalMargin,
                                            y: CellDimensions.Artist.verticalMargin)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        // Layout title label.
        let nameLabelOriginX = profileImageView.frame.width + 2 * CellDimensions.Artist.horizontalMargin
        nameLabel.frame.size = CGSize(width: frame.width - nameLabelOriginX - CellDimensions.Artist.horizontalMargin,
                                      height: CellDimensions.Artist.height / 3)
        nameLabel.frame.origin = CGPoint(x: nameLabelOriginX,
                                         y: CellDimensions.Artist.height / 2 - nameLabel.frame.height / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

