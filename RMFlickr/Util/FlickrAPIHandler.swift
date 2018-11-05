//
//  FlickrAPIHandler.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import Foundation
import Alamofire

class FlickrAPIHandler: FlickrAPIDelegate {
    // Allow for the FlickrAPIHandler to be created as a shared instance if any future view controllers need it.
    static let shared = FlickrAPIHandler()
    
    // Make a REST GET call to the Flickr API.
    func fetchPhotosFromFlickrAPI(completion: @escaping ([RecentPhoto]?, FlickrError?) -> Void) {
        // Alamofire replaces NSURLSession for purposes of efficiency.
        Alamofire.request(FlickrConstants.urlString).responseData(completionHandler: { (response) in
            switch response.result { // success or failure
            case .success: // response was successful
                if let jsonData = response.data {
                    do {
                        // Use JSONDecoder to parse and map JSON into the FlickrPhotos model.
                        let jsonDecoder = JSONDecoder()
                        
                        let flickrPhotos = try jsonDecoder.decode(FlickrPhotos.self, from: jsonData) // FlickrPhotos implements the Codable protocol.
                        
                        // Check if the API key is valid.
                        if flickrPhotos.stat == "ok" {
                            // Fetch the recent photos array from flickrPhotos.
                            let recentPhotos = flickrPhotos.photos.photo
                            completion(recentPhotos, nil)
                        }
                        
                        else {
                            completion(nil, FlickrError.invalidApiKeyError) // The API key is invalid.
                        }
                    } catch let error { // JSON was unable to be decoded, which means that the JSON was blank or changed.
                        print(error)
                        completion(nil, FlickrError.invalidJsonDataError)
                    }
                }
                
                else {
                    completion(nil, FlickrError.noDataResponseError) // There was no data response for other reasons.
                }
            case .failure(let error): // Alert user when unable to connect to server.
                print(error)
                completion(nil, FlickrError.unableToConnectToServerError)
            }
        })
    }
}
