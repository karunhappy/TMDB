//
//  TopRatingModel.swift
//  TestTask
//
//  Created by Karun Aggarwal on 31/08/17.
//  Copyright © 2017 Squareloops. All rights reserved.
//

import Foundation

class GetSet: NSObject {
    /// Validate data & return as String
    static func string(val: Any?) -> String {
        guard (val != nil) else { return "" }
        if val != nil {
            if let notNull =  val as? String {
                return notNull
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    /// Validate data & return as Integer
    static func integer(val: Any?) -> Int {
        var v = 0
        guard (val != nil) else { return 0 }
        if (val != nil) {
            v = val as! Int
        } else {
            v = 0
        }
        return v
    }
    
    /// Image base Url
    static func imageUrl() -> String {
        return "http://image.tmdb.org/t/p/w300"
    }
}

struct TopRating {
    var dict = NSDictionary()
    init(o: NSDictionary) {
        dict = o
    }
    init() {}
    
    /// Fetch vote count greater than 500
    var votes: Bool {
        let vote_count = GetSet.integer(val: dict.value(forKey: "vote_count"))
        return vote_count > 500 ? true : false
    }
    
    /// Fetch title
    var title: String {
        return GetSet.string(val: dict.value(forKey: "title"))
    }
    
    /// Fetch backdrop image path
    var backdrop_path: String {
        return GetSet.imageUrl() + GetSet.string(val: dict.value(forKey: "backdrop_path"))
    }
}
