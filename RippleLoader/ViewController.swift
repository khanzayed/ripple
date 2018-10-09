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
    var firstRippleView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstRippleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        firstRippleView.center = view.center
        view.addSubview(firstRippleView)
        
        drawRingFittingStrokeInsideView(view: firstRippleView)
    }

    @IBAction func startLoaderTapped(_ sender: UIButton) {
//        showLoader(self.view)
    }
    
    @IBAction func endLoaderTapped(_ sender: UIButton) {
//        hideLoader()
    }
    
    private func drawRingFittingInsideView(view : UIView) {
        let halfSize:CGFloat = min(view.bounds.size.width / 2, view.bounds.size.height / 2)
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - 1),
            startAngle: CGFloat(0),
            endAngle:CGFloat(CGFloat.pi * 2),
            clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(hex: "EDEDED").cgColor
        shapeLayer.lineWidth = 2
        view.layer.addSublayer(shapeLayer)
        
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.duration = 1.5
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath
        
        let squareView = UIView()
        squareView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        squareView.layer.cornerRadius = 5.0
        squareView.backgroundColor = UIColor(hex: "428BCA")
        view.addSubview(squareView)
        squareView.layer.add(animation, forKey: nil)
    }
    
    private func drawRingFittingStrokeInsideView(view : UIView) {
        let halfSize:CGFloat = min(view.bounds.size.width / 2, view.bounds.size.height / 2)
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - 1),
            startAngle: CGFloat(0),
            endAngle:CGFloat(CGFloat.pi * 2),
            clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(hex: "EDEDED").cgColor
        shapeLayer.lineWidth = 2
        view.layer.addSublayer(shapeLayer)
        
        let newShapeLayer = CAShapeLayer()
        newShapeLayer.path = circlePath.cgPath
        newShapeLayer.fillColor = UIColor.clear.cgColor
        newShapeLayer.strokeColor = UIColor(hex: "428BCA").cgColor
        newShapeLayer.lineWidth = 3
        newShapeLayer.strokeEnd = 0
        view.layer.addSublayer(newShapeLayer)
        
        let colorAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        colorAnimation.path = circlePath.cgPath
        colorAnimation.toValue = 1
        colorAnimation.duration = 2
        colorAnimation.fillMode = CAMediaTimingFillMode.forwards
        colorAnimation.isRemovedOnCompletion = false
        newShapeLayer.add(colorAnimation, forKey: "strokeEnd")
    }
    
}

