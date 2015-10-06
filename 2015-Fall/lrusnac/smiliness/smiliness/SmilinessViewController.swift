//
//  SmilinessViewController.swift
//  smiliness
//
//  Created by Leonid Rusnac on 22/09/15.
//  Copyright © 2015 Leonid Rusnac. All rights reserved.
//

import UIKit

class SmilinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    // model
    var happiness: Int = 50 { // from 0 to 100
        didSet {
            happiness = min(max(happiness, 0), 100)
            updateUI()
        }
    }
    
    func updateUI() {
        faceView?.setNeedsDisplay()
    }
    
    func smilenessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
    
    func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPoint.zero, inView: faceView)
            }
        default: break
        }
    }
}
