//
//  ViewController.swift
//  MoviesDB
//
//  Created by MCS on 5/4/17.
//  Copyright © 2017 com.mobileconsultingsolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let network: NetworkManager = NetworkManager ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(network.getOffers(query: "Fast"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

