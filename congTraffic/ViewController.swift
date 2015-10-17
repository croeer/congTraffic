//
//  ViewController.swift
//  congTraffic
//
//  Created by Christian Röer on 05.10.15.
//  Copyright © 2015 Christian Röer. All rights reserved.
//

import UIKit
import MobileDataKit

class ViewController: UIViewController {

    @IBOutlet weak var dataView: UsedDataView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = BaseProvider(statsUrl: GlobalConstants.TELEKOM_STATS_URL)
        
        provider.fetchTrafficData { error in
            if error == nil {
                
                let (usedData, fullVolume, _) = parseXmlString(provider.XmlString!)
                
                if let usedData = usedData, fullVolume = fullVolume {
                    self.dataView.totalVolume = fullVolume
                    self.dataView.usedVolume = usedData
                }
                
                //lastUpdateLabel.text = lastUpdateString
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

