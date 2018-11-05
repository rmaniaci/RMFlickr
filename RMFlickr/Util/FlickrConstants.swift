//
//  Constants.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit

// A struct consisting of networking constants that are used by the Flickr API Handler class.
struct FlickrConstants {
    private static let baseUrlString = "https://api.flickr.com/services/rest" // The base URL string used by Flickr.
    private static let method = "flickr.photos.getRecent" // Returns a list of the latest public photos uploaded to Flickr.
    private static let apiKey = "fee10de350d1f31d5fec0eaf330d2dba" // The API key used for the Flickr API.
    private static let format = "json" // Allows that the return format is in JSON.
    private static let noJsonCallback = true // No callbacks when JSON is requested.
    static let urlString = "\(baseUrlString)?method=\(method)&api_key=\(apiKey)&format=\(format)&nojsoncallback=\(String(noJsonCallback))"
}
