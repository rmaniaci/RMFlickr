//
//  FlickrDelegate.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import Foundation

// Delegate protocol that allows for callbacks from the FlickrService.
protocol FlickrDelegate {
    func handleFetchPhotos(fetchedPhotos: [RecentPhoto]) // Callback when the FlickrService successfully fetches recent photos from the Flickr API and provides them to the Thumbnail Table View Controller.
    
    func handleFetchPhotosError(error: FlickrError) // Callback when the FlickrService encounters any sort of error.
}
