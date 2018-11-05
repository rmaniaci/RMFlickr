//
//  FlickrServiceImpl.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit
import Foundation

class FlickrServiceImpl: FlickrService {
    var delegate: FlickrDelegate!
    
    // Allow for the FlickrService to be created as a shared instance if any future view controllers need it.
    static let shared = FlickrServiceImpl()
    
    // Set up the FlickrDelegate to make callbacks.
    func registerDelegate(delegate: FlickrDelegate) {
        self.delegate = delegate
    }
    
    // Fetch the photos by calling the Flickr API Handler.
    func fetchPhotos() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true // get ready to make API call
        FlickrAPIHandler.shared.fetchPhotosFromFlickrAPI(completion: { (recentPhotos: [RecentPhoto]?, error: FlickrError?) -> Void in // making Flickr API call
            UIApplication.shared.isNetworkActivityIndicatorVisible = false // done making API call
            
            if error == nil {
                self.delegate.handleFetchPhotos(fetchedPhotos: recentPhotos!) // go ahead and call the delegate
            } else { // there was an error so it needs to be handled
                self.delegate.handleFetchPhotosError(error: error!)
            }
        })
    }
}
