//
//  GradientLayer.swift
//  Pascal
//
//  Created by Ravi Patel on 5/27/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import Foundation
import UIKit

class GradientLayer{
    static let instance = GradientLayer()
    
    func getGradient(frame: CGRect) -> CAGradientLayer {
        let color1 = UIColor.init(red: (157/255), green: (103/255), blue: (207/255), alpha: 1.0).cgColor
        let color4 = UIColor.init(red: (220/255), green: (173/255), blue: (239/255), alpha: 1.0).cgColor
        
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.frame = CGRect(x: frame.minX, y: 0, width: frame.width * 0.5313432836, height: frame.height)
        gradient1.frame = CGRect(x: 0, y: frame.minY, width: frame.width, height: frame.height * 0.5313432836)
        gradient1.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        
        gradient1.colors = [
            color1,
            color4
        ]
        
        /* make it horizontal */
        gradient1.startPoint = CGPoint(x: 0, y: 0.5)
        gradient1.endPoint = CGPoint(x: 1, y: 0.5)
        
        return gradient1
    }
}
