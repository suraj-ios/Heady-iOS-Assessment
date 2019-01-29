//
//  ViewController.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 28/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import Kingfisher

class MovieListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var movieListObject:[MovieItemModel] = [MovieItemModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "HEADY"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork() == true{
            self.getMovievListFunc()
        }else{
            self.view.makeToast("No Internet connection. Make sure your wi-fi or mobile data is turned on.", point: CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height - 100), title: nil, image: nil, completion: nil)
        }
    }
    
    func getMovievListFunc(){
        SVProgressHUD.show()
        Webservices.sharedInstance.getMovieList(completionHandler: { response in
            SVProgressHUD.dismiss()
            if response.eventListObject.count > 0{
                self.movieListObject = response.eventListObject
                self.collectionView.reloadData()
            }else{
                self.view.makeToast("No Movie list data found.", point: CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height - 100), title: nil, image: nil, completion: nil)
            }
        })
    }
    
    @IBAction func sortListDataFunc(_ sender: Any) {
        let alert = UIAlertController(title: "Alert!", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Most Popular", style: .default , handler:{ (UIAlertAction)in
            self.movieListObject = self.movieListObject.sorted(by: { $0.popularity > $1.popularity })
            self.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Highest Rated", style: .default , handler:{ (UIAlertAction)in
            self.movieListObject = self.movieListObject.sorted(by: { $0.vote_average > $1.vote_average })
            self.collectionView.reloadData()
        }))
        self.present(alert, animated: true, completion:nil)
    }
    
    //collectionview delegate & datasource function
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieListObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        
        cell.movieTitleLabel.text = self.movieListObject[indexPath.row].title
        let url = URL(string: IMAGEPATH + self.movieListObject[indexPath.row].poster_path)
        let resource = ImageResource(downloadURL: url!, cacheKey: "\(url!.absoluteString)-\(indexPath.row)")
        cell.movieListPosterImage.kf.indicatorType = .activity
        cell.movieListPosterImage.kf.setImage(with: resource, options: [.cacheOriginalImage,.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        destination.moviePoster = self.movieListObject[indexPath.row].backdrop_path
        destination.movieTitle = self.movieListObject[indexPath.row].title
        destination.movieRating = String(self.movieListObject[indexPath.row].vote_average)
        destination.movieReleaseDate = self.movieListObject[indexPath.row].release_date
        destination.movieOverView = self.movieListObject[indexPath.row].overview
        
        let navBar = UINavigationController(rootViewController: destination)
        self.present(navBar, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nbCol = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 2))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size - 5, height: 300)
        
    }
    
    @IBAction func presentSearchPageFunc(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "SearchPageViewController") as! SearchPageViewController
        let navBar = UINavigationController(rootViewController: destination)
        self.present(navBar, animated: true, completion: nil)
        
    }
}

