//
//  Helpers.swift
//  test
//
//  Created by Value edge solution on 05/09/17.
//  Copyright © 2017 Value edge solution. All rights reserved.
//

import Foundation
import Alamofire
import Gloss
import Toaster
import Alamofire_Gloss
class Helpers{
    static func webServiceRequest(url:String, viewController:BaseViewController, completionHandler: @escaping (_ songs: [RepoSong]) -> ()) {
        print(url)
        var urlRequest=URLRequest(url:URL(string:url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        urlRequest.httpMethod="GET"
        urlRequest.timeoutInterval=10
        
        viewController.showActivityIndicator()
        Alamofire.request(urlRequest).validate().responseArray(RepoSong.self){ (response) in
            switch response.result {
            case .success(let songs):
                viewController.hideActivityIndicator()
                completionHandler(songs)
            case .failure(let error):
                viewController.hideActivityIndicator()
                print("Error'd: \(error)")
            }
            
        }
        
    }
    
}

struct RepoSong: JSONDecodable {
    
    let name: String?
    let lyrics: String?
    var chords: String?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.name = ("name" <~~ json)
        self.lyrics = ("lyrics" <~~ json)
        self.chords=("chords" <~~ json)
        self.chords=self.chords?.replacingOccurrences(of: "<e>", with: "", options: .literal, range: nil)
    }
    
}
