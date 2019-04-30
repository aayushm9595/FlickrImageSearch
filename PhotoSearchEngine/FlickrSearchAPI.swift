//
//  FlickrSearchAPI.swift
//  FlickrImageSearch
//
//  Created by Aayush Maheshwari on 28/04/19.
//  Copyright © 2019 aayushm95. All rights reserved.
//

import Foundation

struct API{
    enum Endpoint {
        
        case getPagePhotosModel(String,Int)
        case getPhoto(Int,String,String,String)
        
        var urlString : String {
            switch self {
            case .getPagePhotosModel(let searchfield, let pageNo):
                return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(AppCredentials.API_KEY)&format=json&nojsoncallback=1&safe_search=1&text=\(searchfield)&page=\(pageNo)"
            case .getPhoto(let farmID, let server, let id, let secret):
                return "https://farm\(farmID).staticflickr.com/\(server)/\(id)_\(secret).jpg"
            }
        }
        var url: URL{
            return URL(string: urlString)!
        }
    }
}

class AppCredentials {
    
    static let shared = AppCredentials()
    static let API_KEY = "3e7cc266ae2b0e0d78e279ce8e361736"
    private init(){
    
    }
}
