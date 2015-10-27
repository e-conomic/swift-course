//
//  BezierPathView.swift
//  DropIt
//
//  Created by aevitas on 18/10/15.
//  Copyright © 2015 adrian. All rights reserved.
//

import UIKit

class BezierPathView: UIView {
    
    private var bezierPaths = [String:UIBezierPath]()
    
    func setPath(path: UIBezierPath?, named name: String) {
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }
}
