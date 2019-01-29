//
//  JSONArrayFormater.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 28/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONArrayFormater{
    
    func myPurchasePostArray(json:JSON) -> [MovieItemModel]{
        var responseArray = [MovieItemModel]()
        for index:Int in 0 ..< json.count{
            responseArray.append(MovieItemModel(json[index]))
        }
        return responseArray
    }
    
    func searchResultsModelArray(json:JSON) -> [SearchResultsModel]{
        var responseArray = [SearchResultsModel]()
        for index:Int in 0 ..< json.count{
            responseArray.append(SearchResultsModel(json[index]))
        }
        return responseArray
    }
    
}
