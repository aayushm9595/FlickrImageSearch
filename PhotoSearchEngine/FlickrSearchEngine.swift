//
//  FlickrSearchEngine.swift
//  FlickrImageSearch
//
//  Created by Aayush Maheshwari on 28/04/19.
//  Copyright © 2019 aayushm95. All rights reserved.
//

import UIKit

class FlickrSearchEngine {
    
    class func searchPagePhotos(searchField:String, pageNo: Int, completionBlock: @escaping(PhotoSearchRootResponse?,Error?)-> Void) -> URLSessionTask {
        let url = API.Endpoint.getPagePhotosModel(searchField, pageNo).url
        let datatask = URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionBlock(nil,error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let rootResponseModel = try decoder.decode(PhotoSearchRootResponse.self, from: data)
                completionBlock(rootResponseModel,nil)
            }
            catch{
                completionBlock(nil,error)
            }
        }
        datatask.resume()
        return datatask
    }
    
    class func getPhotoUsing(object:PhotoSearchModel,completionBlock:@escaping(Data?,Error?)->Void){
        
        let url = API.Endpoint.getPhoto(object.farm, object.server, object.id, object.secret).url
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else{
                DispatchQueue.main.async {
                    completionBlock(nil,error)
                }
                return
            }
            DispatchQueue.main.async {
                completionBlock(data,nil)
            }
        }
        task.resume()
    }
}
