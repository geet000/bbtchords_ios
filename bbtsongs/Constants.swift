//
//  Constants.swift
//  test
//
//  Created by Value edge solution on 05/09/17.
//  Copyright © 2017 Value edge solution. All rights reserved.
//

import Foundation

struct Constants{
    struct WebServiceUrls{
        static let baseUrl="https://api.mlab.com/api/1/databases/bbtdb/collections/" + WebServiceUrls.collection + WebServiceUrls.apiKey
        static let collection = "song?s={\"name\": 1}"
        static let apiKey="&apiKey=iHKQroKuZB53FzYtZz-AxOVfj_qg9V2o"
        
        
    }
}
