//
//  FlickrImageSearchVC.swift
//  Flickr Image search
//
//  Created by Aayush Maheshwari on 28/04/19.
//  Copyright © 2019 Aayush Maheshwari. All rights reserved.
//

import UIKit

class FlickrImageSearchVC: UIViewController {
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    private var lastsearch  = String()
    
    //MARK:- Local Variables
    private var ImageDataSource :[PhotoSearchModel] = []
    private let cell_identifier = "PhotoDisplayCltnCell"
    private var request : URLSessionTask?
    private var pageNo = 1
    private var maxPages = 1
    //MARK:- UIView Loading...
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerNib()
    }
    
    func registerNib(){
        let cellNib = UINib.init(nibName: cell_identifier, bundle: nil)
        PhotoCollectionView.register(cellNib, forCellWithReuseIdentifier: cell_identifier)
    }
    
    func configureUI(){
        PhotoCollectionView.keyboardDismissMode = .interactive
    }
    
    
    //MARK:- API HIT
    func getPhotosFromFlickr(typedString : String){
        
        
        request = FlickrSearchEngine.searchPagePhotos(searchField: typedString, pageNo: pageNo, completionBlock: {[weak self] (response, error) in
            guard let self = self else {return}
            guard let response = response else{
                print(error?.localizedDescription ?? "Error receiving data ... 404")
                return
            }
            self.maxPages = response.photos.pages
            self.configureDataSource(dataModel: response.photos.photo)
            
            print(response)
        })
        
    }
    
    //MARK:- Configure Collection View Cells
    func configureDataSource(dataModel : [PhotoSearchModel] ){
        
        if ImageDataSource.count > 0{
            ImageDataSource.append(contentsOf: dataModel)
        }
        else{
            ImageDataSource = dataModel
        }
        DispatchQueue.main.async {
            self.PhotoCollectionView.reloadData()
            if(self.ImageDataSource.count>0 && self.pageNo==1){
                self.PhotoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
        

    }
    
    //MARK:- Search Image by field
    @IBAction func searchBtnPressed(_ sender: Any) {
        
        if let request = request{
            request.cancel()
        }
        
        if let  text = SearchTextField.text {
            if (lastsearch != text.lowercased() || lastsearch.isEmpty)  && !text.isEmpty{
                lastsearch = text.lowercased()
                ImageDataSource.removeAll()
                pageNo = 1
                getPhotosFromFlickr(typedString: text)
                
            }
            else if(text.isEmpty)
            {
                ImageDataSource.removeAll()
                PhotoCollectionView.reloadData()
                lastsearch = ""
            }
        }
        else
        {
            lastsearch = ""
        }
    }
}

//MARK:- Extension

extension FlickrImageSearchVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dataobj = ImageDataSource[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_identifier, for: indexPath) as! PhotoDisplayCollectionViewCell
        
        cell.configureUIWithData(dataObj: dataobj)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width)/3-5, height: 128)
    }
    
    // Check if the current page to scrolled is within limit 
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == ImageDataSource.count-1){
            if (pageNo<maxPages), let text = SearchTextField.text{
                pageNo = pageNo + 1
                getPhotosFromFlickr(typedString: text)
            }
        
        }
    }
}
