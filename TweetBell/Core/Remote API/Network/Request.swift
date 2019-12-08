//
//  Request.swift
//  MakebaMoney
//
//  Created by Ibrahima Ciss on 26/08/17.
//  Copyright © 2017 Makeba Inc. All rights reserved.
//

import Foundation

public protocol Request {
    
    var path: String { get }
    var method: HTTPMethod { get }
    var params: RequestParams? { get }
    var headers: [String: String]? { get }
    
}
