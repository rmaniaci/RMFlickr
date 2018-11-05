//
//  FlickrAPIDelegate.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit

// A delegate that the Flickr API Handler implements.
protocol FlickrAPIDelegate {
    func fetchPhotosFromFlickrAPI(completion: @escaping ([RecentPhoto]?, FlickrError?) -> Void) -> Void // Fetch photos from the Flickr API endpoint.
}
