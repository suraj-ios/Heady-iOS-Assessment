//
//  SearchResultsModel.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 29/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchResultsModel{
    var title:String
    var poster_path:String
    var original_title:String
    var backdrop_path:String
    var overview:String
    var release_date:String
    var vote_average:Float
    var popularity:Float
    
    init() {
        self.title = String()
        self.poster_path = String()
        self.original_title = String()
        self.backdrop_path = String()
        self.overview = String()
        self.release_date = String()
        self.vote_average = Float()
        self.popularity = Float()
        
    }
    
    convenience init(_ json: JSON) {
        self.init()
        self.title = json["title"].stringValue
        self.poster_path = json["poster_path"].stringValue
        self.original_title = json["original_title"].stringValue
        self.backdrop_path = json["backdrop_path"].stringValue
        self.overview = json["overview"].stringValue
        self.release_date = json["release_date"].stringValue
        self.vote_average = json["vote_average"].floatValue
        self.popularity = json["popularity"].floatValue
        
    }
}
