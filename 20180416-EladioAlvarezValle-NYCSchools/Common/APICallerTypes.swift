//
//  APICallerTypes.swift
//  20180416-EladioAlvarezValle-NYCSchools
//
//  Created by Eladio Alvarez Valle on 4/16/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import Foundation

enum HttpMethodType : String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case HEAD = "HEAD"
}

enum AuthenticationType {
    case None
    case Basic
    case OAuth2
}
