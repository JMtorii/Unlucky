//
//  QueryItemRepresentable.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-24.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import Foundation

/*
 Abstract:
 Types that conform to the QueryItemRepresentable protocol must implement properties that allow it to be saved as a query item in a URL.
*/
protocol QueryItemRepresentable {
    var queryItem: URLQueryItem { get }
    
    var queryItemKey: String { get }
}

