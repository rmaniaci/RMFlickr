//
//  ShowAlert.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit

extension UIViewController {
    // Alert that handles errors sent from the FlickrService or SDWebImage.
    func errorAlert(error: FlickrError) {
        // Switch based on the type of error and create an alert accordingly that is written in user-friendly terms.
        switch error {
        case FlickrError.unableToConnectToServerError:
            self.showAlert(title: "Server Connection Error", message: "Unable to connect to server. Please check if you have an Internet connection", dismiss: false)
        
        case FlickrError.invalidApiKeyError:
            self.showAlert(title: "Invalid API Key Error", message: "The API key that is used to connect to the Flickr API is invalid. Please request another one from Flickr.", dismiss: false)
        
        case FlickrError.noDataResponseError:
            self.showAlert(title: "No Data Response Error", message: "Unable to retrieve data from the server. Please try again later", dismiss: false)
            
        case FlickrError.invalidJsonDataError:
            self.showAlert(title: "Invalid Data Error", message: "Unable to translate data from the server. This may be because the data is blank or the format has changed", dismiss: false)
            
        case FlickrError.flickrApiError:
            self.showAlert(title: "Flickr Server Error", message: "Unable to retrieve recent photos from Flickr. Please try again later", dismiss: false)
        
        case FlickrError.imageCreationError:
            self.showAlert(title: "Image Creation Error", message: "Unable to create the detail image. Returning to thumbnails.", dismiss: true)
        }
    }
    
    // Show the alert based on the title, message, and whether it should pop the view controller.
    func showAlert(title: String, message: String, dismiss: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        
        if dismiss == false {
            self.present(alertController, animated: true, completion: nil) // just present the alert
        }
        
        else {
            self.present(alertController, animated: true, completion: {
                self.navigationController?.popViewController(animated: true) // dismiss the view controller since this is presented on the photo detail view controller
            })
        }
    }
}
