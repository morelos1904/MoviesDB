//
//  ViewController.swift
//  MoviesDB
//
//  Created by MCS on 5/4/17.
//  Copyright © 2017 com.mobileconsultingsolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,NetworkManagerProtocol {

    let network: NetworkManager = NetworkManager ()
    var results:[Movie] = []
    var resultsOnDisplay:[Movie] = []
    
    @IBOutlet var collectionMovies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.delegate = self
        network.fetchMovies(query: "Fast")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsOnDisplay.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell

        cell.lblMovie.text = resultsOnDisplay[indexPath.row].title
        if(!resultsOnDisplay[indexPath.row].posterPath.isEmpty){
            cell.imgMovie.downloadImageFrom(url: URL(string: "https://image.tmdb.org/t/p/w185/" + resultsOnDisplay[indexPath.row].posterPath)!)
        }else{
            cell.imgMovie.image =  UIImage(named: "not_available")
        }

        return cell
    }

    
    func delegateReceiveLocations(movies: [Movie]) {
        self.results = movies
       
        if(movies.count >= 8){
            self.resultsOnDisplay = Array(movies[0..<8])
        }else{
            self.resultsOnDisplay = movies
        }
       
        DispatchQueue.main.async {
            self.collectionMovies.reloadData()
        }
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
 
        
        if (scrollOffset == 0)
        {
            // then we are at the top
        }
        else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
        {
            // then we are at the end
            addElements()
            
        }
        
    }
    

    func addElements (){
        print(results.count)
        print(resultsOnDisplay.count)
        if(results.count >= resultsOnDisplay.count+8){
            resultsOnDisplay += Array(results[resultsOnDisplay.count..<resultsOnDisplay.count+8])
            collectionMovies.reloadData()
            
        }else{
            if(results.count != resultsOnDisplay.count){
              resultsOnDisplay += Array(results[resultsOnDisplay.count..<results.count])
                collectionMovies.reloadData()
                
            }
        }
        
    }
    
}

