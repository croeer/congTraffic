//
//  ProviderProtocol.swift
//  congTraffic
//
//  Created by Christian Röer on 13.10.15.
//  Copyright © 2015 Christian Röer. All rights reserved.
//

import Foundation

protocol ProviderProtocol {
    
    var XmlString: String? { get }
    func fetchTrafficData(completion: (error: NSError?) -> ())
    
}

public struct GlobalConstants {
    public static let TELEKOM_STATS_URL = "http://pass.telekom.de"
}
