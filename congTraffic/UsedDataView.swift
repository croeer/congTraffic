//
//  UsedDataView.swift
//  congTraffic
//
//  Created by Christian Röer on 17.10.15.
//  Copyright © 2015 Christian Röer. All rights reserved.
//

import Foundation
import UIKit

let π:CGFloat = CGFloat(M_PI)

@IBDesignable public class UsedDataView: UIView {

    @IBInspectable var totalVolume: Double = 100
    @IBInspectable var usedVolume: Double = 25
    @IBInspectable var fillColor: UIColor = UIColor.blueColor()
    @IBInspectable var blassColor: UIColor = UIColor.orangeColor()
    
    override public func drawRect(rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = 120
        let arcWidth: CGFloat = 5
        
        let round = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: 0,
            endAngle: 2*π,
            clockwise: true)

        round.lineWidth = arcWidth
        blassColor.setStroke()
        round.stroke()
        
        let startAngle: CGFloat =   3*π / 2
        let endAngle: CGFloat = 3*π / 2 + CGFloat(usedVolume) / CGFloat(totalVolume) * 2*π

        let path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)

        path.lineWidth = arcWidth
        fillColor.setStroke()
        path.stroke()

    }

}