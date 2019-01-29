//
//  SearchListModel.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 29/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchListModel{
    var page:Int
    var total_results:Int
    var total_pages:Int
    var searchListObject:[SearchResultsModel]
    
    init() {
        self.page = Int()
        self.total_results = Int()
        self.total_pages = Int()
        self.searchListObject = []
        
    }
    
    convenience init(_ json:JSON) {
        self.init()
        self.page = json["page"].intValue
        self.total_results = json["total_results"].intValue
        self.total_pages = json["total_pages"].intValue
        self.searchListObject = JSONArrayFormater().searchResultsModelArray(json: json["results"])
    }
}
