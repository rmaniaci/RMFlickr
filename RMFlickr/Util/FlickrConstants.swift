//
//  Constants.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit

struct FlickrConstants {
    private static let BaseURLString = "https://api.flickr.com/services/rest" // The base URL string used by Flickr.
    private static let Method = "flickr.photos.getRecent" // Returns a list of the latest public photos uploaded to Flickr.
    private static let APIKey = "fee10de350d1f31d5fec0eaf330d2dba" // The API key used for the Flickr API.
    private static let Format = "json" // Allows that the return format is in JSON.
    private static let NoJSONCallback = true // No callbacks when JSON is requested.
    static let URLString = "\(BaseURLString)?method=\(Method)&api_key=\(APIKey)&format=\(Format)&nojsoncallback=\(String(NoJSONCallback))"
}
