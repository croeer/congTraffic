//
//  XmlTools.swift
//  congTraffic
//
//  Created by Christian Röer on 16.10.15.
//  Copyright © 2015 Christian Röer. All rights reserved.
//

import Foundation
import Kanna

public func parseXmlString(xmlString: String) -> (usedData: Double?, fullVolume: Double?, lastUpdateText: String) {
    
    if let doc = Kanna.HTML(html: xmlString, encoding: NSUTF8StringEncoding) {
        
        // Search for nodes by XPath
        let verbrauch = doc.xpath("//*[@id=\'content\']/div[1]/div/div[3]/span")
        let kontingent = doc.xpath("//*[@id=\'content\']/div[1]/div/div[3]")
        let lastUpdated = doc.xpath("//*[@id=\'content\']/p/br/following-sibling::text()")
        
        print(verbrauch.text)
        print(kontingent.text)
        print(lastUpdated.text)
        
        var usedData: Double? = nil
        var fullVolume: Double? = nil
        var lastUpdateText: String = ""
        
        if verbrauch.count == 0 {
            lastUpdateText = "Keine Live-Daten verfügbar. Ist WLAN noch aktiv?"
        } else {
            let parseStrArr = kontingent.text!.characters.split{$0 == " "}.map(String.init)
            usedData = (parseStrArr[0] as NSString).doubleValue
            fullVolume = (parseStrArr[2] as NSString).doubleValue

            lastUpdateText = lastUpdated.text!
        }
        
        return (usedData, fullVolume, lastUpdateText)
        
    }
    
    return (nil, nil, "")
}