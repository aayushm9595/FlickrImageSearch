//
//  PhotoDisplayCollectionViewCell.swift
//  FlickrImageSearch
//
//  Created by Aayush Maheshwari on 30/04/19.
//  Copyright © 2019 aayushm95. All rights reserved.
//

import UIKit
class PhotoDisplayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var PhotoView: UIImageView!
    @IBOutlet weak var LoadingActivityIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.LoadingActivityIndicator.isHidden = true
        // Initialization code
    }
    
    func configureUIWithData(dataObj:PhotoSearchModel?){
        
        LoadingActivityIndicator.startAnimating()
        PhotoView.image = nil;
        self.LoadingActivityIndicator.isHidden = false;
        if let obj = dataObj {
            self.LoadingActivityIndicator.isHidden = false
            FlickrSearchEngine.getPhotoUsing(object: obj) { (data, error) in
                self.LoadingActivityIndicator.stopAnimating()
                self.LoadingActivityIndicator.isHidden = true
                guard let data = data else {
                    return
                }
                let imageData = UIImage(data: data)
                self.PhotoView.image = imageData
            }
        }
    }
}
