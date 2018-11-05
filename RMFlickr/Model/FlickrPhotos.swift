//
//  FlickrPhotos.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import Foundation

// A series of structs that represent recent photos fetched from the Flickr API that conform to the Codable protocol. This allows for the simplification of JSON parsing and mapping.

// {"photos":{"page":1,"pages":10,"perpage":100,"total":1000},"stat":"ok"}

// Wrapper for the Photos instance.
struct FlickrPhotos : Codable {
    let photos: Photos
    let stat: String // Status of the Flickr API.
}

// Metadata that includes array of recent photos fetched from the Flickr API.
struct Photos : Codable {
    let page, pages, perpage, total: Int // Page out of set of pages, photos per page, and total photos. Pages are an argument that can be set when the Flickr API call is made.
    let photo: [RecentPhoto] // Array of recent photos fetched from the Flickr API.
}

struct RecentPhoto: Codable {
    let photoId, owner, secret, server: String // Data used to construct a photo URL.
    let farm: Int // Farm ID also used to construct a photo URL.
    let title: String // Self-explanatory, the title of the photo as set by the Flickr user.
    let ispublic, isfriend, isfamily: Int // Integers that determine the visibility level of a photo (public, friend, or family)
    
    // The photo URL that is constructed using the above data.
    var photoUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret).jpg")!
    }
    
    // The CodingKeys enumeration allows for the "id" key to be mapped to the photoId property.
    enum CodingKeys: String, CodingKey {
        case photoId = "id", owner, secret, server
        case farm
        case title
        case ispublic, isfriend, isfamily
    }
}
