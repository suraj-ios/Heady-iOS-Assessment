//
//  MoviewListModel.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 28/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation
import SwiftyJSON

class MoviewListModel{
    
    var eventListObject:[MovieItemModel]
    
    init() {
        self.eventListObject = []
    }
    
    convenience init(_ json: JSON) {
        self.init()
        self.eventListObject = JSONArrayFormater().myPurchasePostArray(json: json["items"])
    }
    
}
