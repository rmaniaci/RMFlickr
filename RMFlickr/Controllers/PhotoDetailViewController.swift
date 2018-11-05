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
            if error != nil { // Equvalent of FlickrError.ImageCreationError
                self.showDetailAlert(title: "Image Creation Error", message: "Unable to create the detail image.")
            }
            
            self.navigationItem.title = self.recentPhoto.title // Set the title of the view to that of the photo.
        })
    }
    
    // Change the status bar color to white.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Unlike showThumbnailAlert, this alert controller dismisses the photo detail view controller when the OK button is pressed.
    private func showDetailAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
}
