//
//  SearchPageViewController.swift
//  HeadyAssessmentProject
//
//  Created by Suraj on 29/01/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import Kingfisher

class SearchPageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    var searchListObject:[SearchResultsModel] = [SearchResultsModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    var searchController: UISearchController!
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search"
        searchController = UISearchController(searchResultsController: nil)
        self.configureSearchController()
        
    }
    
    func configureSearchController() {
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.keyboardType = UIKeyboardType.asciiCapable
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.collectionView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.collectionView.reloadData()
        }
        if (searchBar.text?.isEmpty)!{
        }else{
            if Reachability.isConnectedToNetwork() == true{
                self.searchAPI(searchBar.text!)
            }else{
                self.view.makeToast("No Internet connection. Make sure your wi-fi or mobile data is turned on.", point: CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height - 100), title: nil, image: nil, completion: nil)
            }
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchAPI(_ searchText:String){
        SVProgressHUD.show()
        Webservices.sharedInstance.getSearchList(searchText, completionHandler: { response in
            SVProgressHUD.dismiss()
            if response.total_results != 0{
                self.searchListObject = response.searchListObject
                self.collectionView.reloadData()
                self.searchController.searchBar.text = ""
                self.searchController.dismiss(animated: true, completion: nil)
            }else{
                self.view.makeToast("No search data found.", point: CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height - 100), title: nil, image: nil, completion: nil)
            }
        })
    }
    
    //collectionview delegate & datasource function
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchListObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        
        cell.movieTitleLabel.text = self.searchListObject[indexPath.row].title
        
        let url = URL(string: IMAGEPATH + self.searchListObject[indexPath.row].poster_path)
        let resource = ImageResource(downloadURL: url!, cacheKey: "\(url!.absoluteString)-\(indexPath.row)")
        cell.movieListPosterImage.kf.indicatorType = .activity
        cell.movieListPosterImage.kf.setImage(with: resource, options: [.cacheOriginalImage,.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        destination.moviePoster = self.searchListObject[indexPath.row].backdrop_path
        destination.movieTitle = self.searchListObject[indexPath.row].title
        destination.movieRating = String(self.searchListObject[indexPath.row].vote_average)
        destination.movieReleaseDate = self.searchListObject[indexPath.row].release_date
        destination.movieOverView = self.searchListObject[indexPath.row].overview
        
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
    
    @IBAction func presentSearchBarFunc(_ sender: Any) {
        configureSearchController()
    }
    
    @IBAction func dismissSearchPageFunc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sortListDataFunc(_ sender: Any) {
        let alert = UIAlertController(title: "Alert!", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Most Popular", style: .default , handler:{ (UIAlertAction)in
            self.searchListObject = self.searchListObject.sorted(by: { $0.popularity > $1.popularity })
            self.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Highest Rated", style: .default , handler:{ (UIAlertAction)in
            self.searchListObject = self.searchListObject.sorted(by: { $0.vote_average > $1.vote_average })
            self.collectionView.reloadData()
        }))
        self.present(alert, animated: true, completion:nil)
    }
    
}
