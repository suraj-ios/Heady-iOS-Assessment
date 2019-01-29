//
//  Webservices.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 28/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Webservices{
    
    static let sharedInstance = Webservices()
    
    func getMovieList(completionHandler: @escaping(_ moviewListModelArray:MoviewListModel) -> ()){
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        Alamofire.request(MOVIELIST, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            //print(response)
            if let body = response.result.value{
                let json = JSON(body)
                let responseBody = MoviewListModel.init(json)
                completionHandler(responseBody)
            }
        }
    }
    
    func getSearchList(_ searchText:String, completionHandler: @escaping(_ searchListModel:SearchListModel) -> ()){
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        Alamofire.request(SEARCHLIST + searchText + "&api_key=" + API_KEY + "&language=en-US&page=1&include_adult=false", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            //print(response)
            if let body = response.result.value{
                let json = JSON(body)
                let responseBody = SearchListModel.init(json)
                completionHandler(responseBody)
            }
        }
    }
    
}
