//
//  PhotoDetailViewController.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit
import SDWebImage

// Photo details view controller that displays larger photo from corresponding cell in table view controller.
class PhotoDetailViewController: UIViewController {
    var recentPhoto: RecentPhoto! // Photo from tapped cell
    @IBOutlet weak var photoDetailView: UIImageView! // Image view to display larger photo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SDWebImage is used to asynchronously download and cache the photo for purposes of efficiency.
        photoDetailView.sd_setShowActivityIndicatorView(true) // show an activity indicator view
        photoDetailView.sd_setIndicatorStyle(.whiteLarge)
        
        // Set the image.
        photoDetailView.sd_setImage(with: recentPhoto.photoUrl as URL, completed: {(image, error, cacheType, imageURL) in // use the photo url corresponding to the photo that is being displayed in detail
            if error != nil {
                self.errorAlert(error: FlickrError.imageCreationError) // unable to create the detail image
            }
            
            // Set the title of the view to that of the photo. If the title is blank, leave the title as "Untitled."
            if self.recentPhoto.title.count != 0 {
                self.navigationItem.title = self.recentPhoto.title
            }
        })
    }
    
    // Change the status bar color to white.
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
