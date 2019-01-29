//
//  MovieItemModel.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 28/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieItemModel{
    var vote_average:Float
    var title:String
    var original_title:String
    var poster_path:String
    var overview:String
    var release_date:String
    var backdrop_path:String
    var popularity:Float
    
    init() {
        self.vote_average = Float()
        self.title = String()
        self.original_title = String()
        self.poster_path = String()
        self.overview = String()
        self.release_date = String()
        self.backdrop_path = String()
        self.popularity = Float()
        
    }
    
    convenience init(_ json: JSON) {
        self.init()
        self.vote_average = json["vote_average"].floatValue
        self.title = json["title"].stringValue
        self.original_title = json["original_title"].stringValue
        self.poster_path = json["poster_path"].stringValue
        self.overview = json["overview"].stringValue
        self.release_date = json["release_date"].stringValue
        self.backdrop_path = json["backdrop_path"].stringValue
        self.popularity = json["popularity"].floatValue
        
    }
}
