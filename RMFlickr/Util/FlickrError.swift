//
//  Flickr.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import Foundation

// Enum consisting of self-explanatory errors that occur throughout the app.
enum FlickrError: Error {
    case unableToConnectToServerError
    case invalidApiKeyError
    case noDataResponseError
    case invalidJsonDataError
    case flickrApiError
    case imageCreationError
}
