//
//  ViewController.swift
//  TestTask
//
//  Created by Karun Aggarwal on 31/08/17.
//  Copyright © 2017 Squareloops. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var collectionNewTheatre: UICollectionView!
    @IBOutlet var collectionPopular: UICollectionView!
    @IBOutlet var collectionHighRating: UICollectionView!
    
    struct Cells {
        let NewTheatre = "NewTheatreCell"
        let Popular    = "PopularCell"
        let Highrating = "TopRatedCell"
    }
    
    var arrayTopRating = NSArray()
    var arrayPopular   = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.loadData()
    }
    
/// On start or load the controller
    func setup() {
        self.addConstraints()
        self.registerNibs()
    }
    
    func addConstraints() {
        /// Add constraints for "New in Theatre" Collection View
        collectionNewTheatre.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
            let topGuide: UIView = self.topLayoutGuide as! UIView
            make.top.equalTo(topGuide.snp.bottom)
            
            let h = (Common.share.screenSize.height - 64) / 3
            make.height.equalTo(h)
        }
        
        /// Add constraints for "Popular" Collection View
        collectionPopular.snp.makeConstraints { (make) in
            make.leading.equalTo(collectionNewTheatre.snp.leading)
            make.trailing.equalTo(collectionNewTheatre.snp.trailing)
            make.top.equalTo(collectionNewTheatre.snp.bottom)
            make.height.equalTo(collectionNewTheatre.snp.height)
        }
        
        /// Add constraints for "highest Rating this Year" Collection View
        collectionHighRating.snp.makeConstraints { (make) in
            make.leading.equalTo(collectionNewTheatre.snp.leading)
            make.trailing.equalTo(collectionNewTheatre.snp.trailing)
            make.top.equalTo(collectionPopular.snp.bottom)
            make.height.equalTo(collectionNewTheatre.snp.height)
        }
    }
    
/// Register CollectionView Nib
    func registerNibs() {
        self.collectionHighRating.register(self.nib(), forCellWithReuseIdentifier: Cells().Highrating)
        self.collectionPopular.register(self.nib(), forCellWithReuseIdentifier: Cells().Popular)
    }
    
    func nib() -> UINib {
        return UINib(nibName: "MoviesCollectionCell", bundle: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
/// Load data for all the categories
    func loadData() {
        self.loadTopRatedMovies()
        self.loadPopularMovies()
    }
    
/// Load Top Rated Movie data
    func loadTopRatedMovies() {
        API.getApi(controller: self, method: API.topRated, param: [:]) { (result) in
            if result != nil {
                print("Got result: ", result!)
                guard let returned = result?.value(forKey: "results") else { return }
                self.arrayTopRating = returned as! NSArray
                self.collectionHighRating.reloadData()
            }
        }
    }
    
/// Load Popular data
    func loadPopularMovies() {
        API.getApi(controller: self, method: API.popular, param: [:]) { (result) in
            if result != nil {
                print("Got result: ", result!)
                guard let returned = result?.value(forKey: "results") else { return }
                self.arrayPopular = returned as! NSArray
                self.collectionPopular.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var counts = 0
        switch collectionView {
        case collectionNewTheatre:
            counts = 0
            break
        case collectionPopular:
            counts = self.arrayPopular.count
            break
        case collectionHighRating:
            counts = self.arrayTopRating.count
            break
        default:
            break
        }
        return counts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier = ""
        var array = NSArray()
        
        if collectionView.isEqual(self.collectionNewTheatre) {
            identifier = Cells().NewTheatre
            array = []
        } else if collectionView.isEqual(self.collectionPopular) {
            identifier = Cells().Popular
            array = self.arrayPopular
        } else {
            identifier = Cells().Highrating
            array = self.arrayTopRating
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MoviesCollectionCell
       
        guard array.count > 0 else { return cell }
        
        cell.updateHighRatingCell(obj: array[indexPath.row] as! NSDictionary)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.collectionHighRating.bounds.height) - collectionView.contentInset.top - collectionView.contentInset.bottom
        let width  = (self.collectionHighRating.bounds.width) - collectionView.contentInset.left - collectionView.contentInset.right
        return CGSize(width: width, height: height)
    }
}
