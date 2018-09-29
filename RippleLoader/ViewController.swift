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
        
        loaderView = LoaderView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        loaderView.center = view.center
        view.addSubview(loaderView)
        
        loaderView.startAnimating()
    }
    
    @IBAction func endLoaderTapped(_ sender: UIButton) {
        loaderView.removeFromSuperview()
        loaderView.removeViews()
        loaderView = nil
    }
    
}

