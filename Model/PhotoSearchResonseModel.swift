//
//  PhotoSearchResonseModel.swift
//  FlickrImageSearch
//
//  Created by Aayush Maheshwari on 28/04/19.
//  Copyright © 2019 aayushm95. All rights reserved.
//

import Foundation

struct PhotoSearchRootResponse: Codable{
    let photos : PhotoSearchPageResponse
}

struct PhotoSearchPageResponse: Codable{
    let page : Int
    let pages : Int
    let perpage : Int
    let total : String
    let photo : [PhotoSearchModel]
}

struct PhotoSearchModel : Codable{
    let id            :String
    let owner         :String
    let secret        :String
    let server        :String
    let farm          :Int
    let title         :String
    let ispublic      :Int
    let isfriend      :Int
    let isfamily      :Int
}
