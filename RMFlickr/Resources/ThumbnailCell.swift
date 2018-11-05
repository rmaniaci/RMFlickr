//
//  ThumbnailCell.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit
import SDWebImage

class ThumbnailCell: UITableViewCell {
    @IBOutlet weak var thumbnailView: UIImageView! // Thumbnail image.
    @IBOutlet weak var photoTitle: UILabel! // Photo title
    
    // Configure the ThumbnailCell.
    func configure(recentPhoto: RecentPhoto) {
        // SDWebImage is used to asynchronously download and cache the photo for purposes of efficiency.
        thumbnailView.sd_setShowActivityIndicatorView(true)
        thumbnailView.sd_setIndicatorStyle(.white)
        self.photoTitle.text = ""
        
        // Set the image.
        thumbnailView.sd_setImage(with: recentPhoto.photoUrl as URL, completed: {(image, error, cacheType, imageURL) in // use the photo url corresponding to the photo that is being displayed in the thumbnail
            if error != nil { // Equivalent of FlickrError.ImageCreationError
                print ("Error")
                // self.showDetailAlert(title: "Image Creation Error", message: "Unable to create the detail image.")
            }
            
            // Set the title of the cell to that of the photo. If the title is blank, set the title as "Untitled."
            if recentPhoto.title.count != 0 {
                self.photoTitle.text = recentPhoto.title
            }
            
            else {
                self.photoTitle.text = "Untitled"
            }
        })
    }
}
