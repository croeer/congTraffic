//
//  TelekomProvider.swift
//  congTraffic
//
//  Created by Christian Röer on 13.10.15.
//  Copyright © 2015 Christian Röer. All rights reserved.
//

import Foundation

public class BaseProvider : ProviderProtocol {
    
    public var XmlString: String?
    public var StatsUrl: String = ""
    
    public init(statsUrl: String) {
        self.StatsUrl = statsUrl
    }
    
    public func fetchTrafficData(completion: (error: NSError?) -> ()) {
        self.getStats { xmlString, error in
            dispatch_async(dispatch_get_main_queue()) {
                self.XmlString = xmlString!
                completion(error: error)
            }
        }
    }
    
    func getStats(completion: (xmlString: String?, error: NSError?) -> ()) {
        
        let userAgent = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5"
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["User-Agent" : userAgent]
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: StatsUrl)!
        let task = session.dataTaskWithURL(url) {
            (let data, let response, let error) in
            if error == nil {
                if let _ = response as? NSHTTPURLResponse {
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(dataString)
                    completion(xmlString: dataString as? String, error: nil)
                }
            } else {
                completion(xmlString: nil, error: error)
            }
        }
        
        task.resume()
        
    }
    
}