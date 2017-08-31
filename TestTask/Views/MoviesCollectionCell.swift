//
//  MoviesCollectionCell.swift
//  TestTask
//
//  Created by Karun Aggarwal on 31/08/17.
//  Copyright © 2017 Squareloops. All rights reserved.
//

import UIKit
import SnapKit

class MoviesCollectionCell: UICollectionViewCell {

    @IBOutlet var lblMovieTitle: UILabel!
    @IBOutlet var imgMovieImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgMovieImage.layer.cornerRadius = 10
        
        self.loadConstraints()
    }

    func loadConstraints() {
    /// Add constraints for Movie Title Label
        lblMovieTitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
    /// Add constraints for Movie Image
        imgMovieImage.snp.makeConstraints { (make) in
            let title = lblMovieTitle.snp
            make.leading.equalTo(title.leading)
            make.trailing.equalTo(title.trailing)
            make.top.equalTo(title.bottom).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints { (make) in
            let title = lblMovieTitle.snp
            make.leading.equalTo(title.leading)
            make.trailing.equalTo(title.trailing)
            make.height.equalTo(1)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
        }
    }
    
    func updateHighRatingCell(obj: NSDictionary) {
        let object = TopRating(o: obj)
        if object.votes {
            lblMovieTitle.text = object.title
            Common.share.loadImage(img: self.imgMovieImage, url: URL(string: object.backdrop_path)!)
        }
    }
}
