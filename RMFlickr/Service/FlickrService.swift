//
//  FlickrService.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import Foundation

// A protocol that is implemented by the FlickrServiceImpl class.
protocol FlickrService {
    func registerDelegate(delegate: FlickrDelegate) // Registers the FlickrDelegate.
    
    func fetchPhotos() // Fetch photos by using the Flickr API Handler.
}
