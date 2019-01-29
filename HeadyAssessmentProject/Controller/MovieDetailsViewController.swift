
//
//  MovieDetailsViewController.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 28/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieOverViewLabelOutlet: UILabel!
    @IBOutlet weak var movieRatingLabelOutlet: UILabel!
    @IBOutlet weak var movieReleaseDateLabelOutlet: UILabel!
    @IBOutlet weak var movieTitleLabelOutlet: UILabel!
    @IBOutlet weak var moviePosterImageOutlet: UIImageView!
    var moviePoster:String = ""
    var movieTitle:String = ""
    var movieOverView:String = ""
    var movieRating:String = ""
    var movieReleaseDate:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Details"
        
        let url = URL(string: IMAGEPATH + self.moviePoster)
        let resource = ImageResource(downloadURL: url!, cacheKey: "\(url!.absoluteString)-\(0)")
        self.moviePosterImageOutlet.kf.indicatorType = .activity
        self.moviePosterImageOutlet.kf.setImage(with: resource, options: [.cacheOriginalImage,.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
        self.movieTitleLabelOutlet.text = self.movieTitle
        self.movieRatingLabelOutlet.text = self.movieRating
        self.movieReleaseDateLabelOutlet.text = self.movieReleaseDate
        self.movieOverViewLabelOutlet.text = self.movieOverView
        
    }

    @IBAction func dismissPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
