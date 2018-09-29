//
//  DetailViewController.swift
//  RippleLoader
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 BlueTie. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showLoader(self.view)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        hideLoader()
    }
    
    deinit {
        print("De - init called on DetailViewController")
    }
    
}
