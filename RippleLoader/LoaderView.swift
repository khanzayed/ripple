//
//  LoaderView.swift
//  RippleLoader
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 BlueTie. All rights reserved.
//

import Foundation
import UIKit

fileprivate var loaderView : LoaderView?

internal func showLoader(_ onView : UIView) {
    if loaderView != nil {
        hideLoader()
    }
    
    loaderView = LoaderView(frame: onView.frame)
    onView.addSubview(loaderView!)
    
    loaderView!.startAnimating()
}

internal func hideLoader() {
    if loaderView != nil {
        loaderView!.removeFromSuperview()
        loaderView!.removeViews()
        loaderView = nil
    }
}

class LoaderView : UIView {
    
    var baseView : UIView!
    var firstRippleView : UIView?
    var secondRippleView : UIView?
    var thirdRippleView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(rgba: "#F1F1F1")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterBackground), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterBackground), name: UIApplication.navi, object: <#T##Any?#>)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("De - init called on LoaderView")
    }
    
    func setupView() {
        baseView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        baseView.center = self.center
        
        firstRippleView = UIView(frame: CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.width))
        secondRippleView = UIView(frame: CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height))
        thirdRippleView = UIView(frame: CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height))

        drawRingFittingInsideView(view: firstRippleView!)
        drawRingFittingInsideView(view: secondRippleView!)
        drawRingFittingInsideView(view: thirdRippleView!)

        baseView.addSubview(firstRippleView!)
        baseView.addSubview(secondRippleView!)
        baseView.addSubview(thirdRippleView!)
        
        self.addSubview(baseView)
    }
    
    private func drawRingFittingInsideView(view : UIView) {
        let halfSize:CGFloat = min(baseView.bounds.size.width / 2, baseView.bounds.size.height / 2)
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - 1),
            startAngle: CGFloat(0),
            endAngle:CGFloat(CGFloat.pi * 2),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(hex: "428BCA").cgColor
        shapeLayer.lineWidth = 2
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func startAnimating() {
        self.firstRippleView?.alpha = 1
        self.firstRippleView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        self.secondRippleView?.alpha = 1
        self.secondRippleView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        self.thirdRippleView?.alpha = 1
        self.thirdRippleView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)

        UIView.animate(withDuration: 1.2, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.firstRippleView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.firstRippleView?.alpha = 0
        }) { (true) in
            self.firstRippleView?.alpha = 1
            self.firstRippleView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }
        
        UIView.animate(withDuration: 1.2, delay: 0.4, options: [.repeat, .curveLinear], animations: {
            self.secondRippleView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.secondRippleView?.alpha = 0
        }) { (true) in
            self.secondRippleView?.alpha = 1
            self.secondRippleView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }
        
        UIView.animate(withDuration: 1.2, delay: 0.8, options: [.repeat, .curveLinear], animations: {
            self.thirdRippleView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.thirdRippleView?.alpha = 0
        }) { (true) in
            self.thirdRippleView?.alpha = 1
            self.thirdRippleView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }
    }
    
    func removeViews() {
        firstRippleView!.removeFromSuperview()
        secondRippleView!.removeFromSuperview()
        thirdRippleView!.removeFromSuperview()
        
        firstRippleView!.layer.removeAllAnimations()
        secondRippleView!.layer.removeAllAnimations()
        thirdRippleView!.layer.removeAllAnimations()
        
        baseView.removeFromSuperview()
        
        firstRippleView = nil
        secondRippleView = nil
        thirdRippleView = nil
        baseView = nil
    }
    
    @objc func applicationDidEnterBackground() {
        self.setupView()
        self.startAnimating()
    }
    
    @objc func applicationWillEnterBackground() {
        self.removeViews()
    }
    
}

extension UIColor {
    
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            
            let index   = rgba.index(rgba.startIndex, offsetBy: 1)
            let hex     = String(rgba[index...])
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                
                if 6 == hex.count {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if 8 == hex.count {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9")
                }
            } else {
                print("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    convenience init(hex: String, alpha:CGFloat) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
}
