//
//  ViewController.swift
//  MoviesDB
//
//  Created by MCS on 5/4/17.
//  Copyright © 2017 com.mobileconsultingsolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,NetworkManagerProtocol,UISearchResultsUpdating {

    let network: NetworkManager = NetworkManager ()
    var results:[Movie] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies:[Movie] = []
    var flag = false

    @IBOutlet var collectionMovies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell

        cell.lblMovie.text = results[indexPath.row].title
        if(!results[indexPath.row].posterPath.isEmpty){
            cell.imgMovie.downloadImageFrom(url: URL(string: "https://image.tmdb.org/t/p/w185/" + results[indexPath.row].posterPath)!)
        }else{
            cell.imgMovie.image =  UIImage(named: "not_available")
        }

        return cell
    }

    
    func delegateReceiveLocations(movies: [Movie]) {
        results = movies
       
//        let x = results.map{$0.title}
//        print(x)
        
        
//        if(movies.count >= 8){
//            self.resultsOnDisplay = Array(movies[0..<8])
//        }else{
//            self.resultsOnDisplay = movies
//        }
       
        self.collectionMovies.reloadData()
    }
    
//     func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let scrollViewHeight = scrollView.frame.size.height
//        let scrollContentSizeHeight = scrollView.contentSize.height
//        let scrollOffset = scrollView.contentOffset.y
//
//        if (scrollOffset == 0)
//        {
//            // then we are at the top
//        }
//        else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
//        {
//            // then we are at the end
//        //    addElements()
//        }
//        
//    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView  (ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
            if !flag{
                headerView.addSubview(searchController.searchBar)
                flag = true
            }
            return headerView
        }
        return UICollectionReusableView()
    }


    public func updateSearchResults(for searchController: UISearchController) {
        network.fetchMovies(query: searchController.searchBar.text!)
    }
    
    func addElements (){
//        if(results.count >= resultsOnDisplay.count+8){
//            resultsOnDisplay += Array(results[resultsOnDisplay.count..<resultsOnDisplay.count+8])
//            collectionMovies.reloadData()
//        }else{
//            if(results.count != resultsOnDisplay.count){
//              resultsOnDisplay += Array(results[resultsOnDisplay.count..<results.count])
//                collectionMovies.reloadData()
//            }
//        }
        
    }
    

    
}

