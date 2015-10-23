//
//  TodayViewController.swift
//  congWidget
//
//  Created by Christian Röer on 05.10.15.
//  Copyright © 2015 Christian Röer. All rights reserved.
//

import UIKit
import NotificationCenter
import Kanna
import Foundation
import MobileDataKit

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var usageLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    typealias StatsCompletionBlock = (xmlString: String?, error: NSError?) -> ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        let provider = BaseProvider(statsUrl: GlobalConstants.TELEKOM_STATS_URL)
        
        provider.fetchTrafficData { error in
            if error == nil {
                self.updatePriceLabel(provider.XmlString!)
                completionHandler(.NewData)
            } else {
                completionHandler(.NoData)
            }
        }
        
    }
    
    func updatePriceLabel(xmlString: String) {

        let (usedData, fullVolume, lastUpdateString) = parseXmlString(xmlString)
        
        if let usedDataStr = usedData, fullVolumeStr = fullVolume {
            usageLabel.text = "\(usedDataStr) MB von \(fullVolumeStr) GB verbraucht"
        }
        
        lastUpdateLabel.text = lastUpdateString
        
    }

}
