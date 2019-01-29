//
//  WebservicesAPIEndPoint.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 28/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation

let PROTOCOL = "https://"
let BASEURL = "api.themoviedb.org/3/"
let API_KEY = "1105183fa3c67349c8309d4b6710e536"
let IMAGEPATH = "https://image.tmdb.org/t/p/w500"

//https://api.themoviedb.org/3/list/1?api_key=1105183fa3c67349c8309d4b6710e536&language=en-US
//https://api.themoviedb.org/3/search/movie?query=t&api_key=1105183fa3c67349c8309d4b6710e536&language=en-US&page=1&include_adult=false

let MOVIELIST = PROTOCOL + BASEURL + "list/1?api_key=" + API_KEY
let SEARCHLIST = PROTOCOL + BASEURL + "search/movie?query="
