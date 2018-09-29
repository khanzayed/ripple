//
//  ViewController.swift
//  RippleLoader
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 BlueTie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loaderView : LoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func startLoaderTapped(_ sender: UIButton) {
        showLoader(self.view)
    }
    
    @IBAction func endLoaderTapped(_ sender: UIButton) {
        hideLoader()
    }
    
}

