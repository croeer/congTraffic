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
                self.updatePriceLabel(provider.XmlString)
                completionHandler(.NewData)
            } else {
                completionHandler(.NoData)
            }
        }
        
    }
    
    func updatePriceLabel(xmlString: String?) {
        
        // let testString = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html><head><meta name=\"viewport\" content=\"width=device-width\" /><meta name=\"apollo-target-device\" content=\"Safari_OSX\" /><meta name=\"apollo-page-id\" content=\"home\" /><meta name=\"language\" content=\"de\" /><meta name=\"mobile-web-app-title\" content=\"Datennutzung\" /><meta name=\"apple-mobile-web-app-title\" content=\"Datennutzung\" /><title>Datennutzung -  </title><link rel=\"stylesheet\" type=\"text/css\" href=\"/styles/css3-web-safari$web$CONG.css\" /><script type=\"text/javascript\" src=\"/scripts/web.js\"></script></head><body class=\"speed pad\" onload=\"init();\"><div id=\"screenHeaderBar\"> </div><div id=\"page_home\" class=\"container\"><a id=\"lnkHome\" name=\"lnkHome\" href=\"/home\" class=\"logoLink\"><div id=\"logoBar\"><div id=\"logoLeft\"> </div><div id=\"logoRight\">Datennutzung</div></div></a><div id=\"titleBar\"><h2 id=\"pageTitle\" class=\"title\"> </h2><div class=\"hr\"><hr /></div></div><div id=\"content\" class=\"pageContent\"><div class=\"passStatus\"><div class=\"progress emphasized\"><div class=\"barTextAbove color_default\"></div><div class=\"progressBar\"><div class=\"indicator color_default\" style=\"width:5%\"> </div></div><div class=\"barTextBelow color_default\"><span class=\"colored\">66,66 MB</span> von 1 GB verbraucht</div></div><table class=\"frame\"><tr class=\"infoLine\"><td><table><tr><td class=\"infoLabel billingPeriod\">Abrechnungsmonat:</td><td class=\"infoValue billingPeriod\">Oktober 2015</td></tr></table></td></tr><tr class=\"infoLine\"><td><table><tr><td class=\"infoLabel remainingTime\">Verbleibende Zeit:</td><td class=\"infoValue remainingTime\"><span class=\"value\">26</span> Tage <span class=\"value\">5</span> Std.</td></tr></table></td></tr><tr class=\"infoLine\"><td><table><tr><td class=\"infoLabel totalVolume\">Datennutzung:</td><td class=\"infoValue totalVolume\">Unbegrenzt</td></tr></table></td></tr><tr class=\"infoLine\"><td><table><tr><td class=\"infoLabel maxBandwidth\">Download-Geschwindigkeit:</td><td class=\"infoValue maxBandwidth\">max. 7.2 Mbit/s</td></tr></table></td></tr></table></div><div class=\"infoBox exhaustionInfo\">Wenn Sie 1 GB im laufenden Monat verbraucht haben, reduziert sich Ihre Surf-Geschwindigkeit.</div><p>Die angezeigten Informationen sind zeitverzögert und können vom tatsächlichen Verbrauch abweichen.<br/>Letzte Aktualisierung: 28.10.2015 um 11:07 Uhr (MEZ/MESZ)</p><p></p><div><p class=\"bookmark\">Tipp: Richten Sie sich ein Lesezeichen für diese Seite ein!</p></div></div><div id=\"footer\"><p id=\"customerCare\" class=\"customerCare\">Bei Rückfragen wenden Sie sich bitte an Ihren Kundenservice:<br/>01806&#160;324&#160;444&#160; (20 Cent pro Verbindung aus dem Festnetz; aus dem Mobilfunknetz 60 Cent pro Verbindung)</p><p id=\"costInfo\" class=\"costInfo\">Diese Seite ist für Sie kostenfrei.</p><div id=\"links\"><div id=\"copyright\"> </div><p><a href=\"/history/domestic\">Buchungen</a> | <a href=\"/imprint\">Impressum</a></p></div></div></div><div id=\"overlay\" class=\"hidden\"> </div><div id=\"popup\" class=\"hidden\"><div class=\"loading\"> </div></div></body></html>"
        
        if let doc = Kanna.HTML(html: xmlString!, encoding: NSUTF8StringEncoding) {
            
            // Search for nodes by XPath
            let verbrauch = doc.xpath("//*[@id=\'content\']/div[1]/div/div[3]/span")
            let kontingent = doc.xpath("//*[@id=\'content\']/div[1]/div/div[3]")
            let lastUpdated = doc.xpath("//*[@id=\'content\']/p/br/following-sibling::text()")
            
            print(verbrauch.text)
            print(kontingent.text)
            print(lastUpdated.text)

            if verbrauch.count == 0 {
                usageLabel.text = "-- MB von -- GB verbraucht"
                lastUpdateLabel.text = "Keine Live-Daten verfügbar. Ist WLAN noch aktiv?"
                
            } else {
                usageLabel.text = kontingent.text
                lastUpdateLabel.text = lastUpdated.text
            }
            
        }
        

    }
    
}
