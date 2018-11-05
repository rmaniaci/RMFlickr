//
//  ThumbnailTableViewController.swift
//  RMFlickr
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import UIKit

class ThumbnailTableViewController: UITableViewController {
    var recentPhotos = [RecentPhoto]() // An array of photos used to populate the table view.
    var flickrService: FlickrService! // FlickrService handles all of the non-UI stuff.
    
    // Initialize the FlickrService class and the FlickrDelegate protocol.
    func initService() {
        flickrService = FlickrServiceImpl.shared
        flickrService.registerDelegate(delegate: self)
    }
    
    // Once FlickrService is initialized, the fetchPhotos() method is called.
    override func viewDidLoad() {
        super.viewDidLoad()
        initService()
        flickrService.fetchPhotos()
    }
    
    // Change the status bar color to white.
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - UITableViewDataSource
    
    // Only one section in this table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Initially there will be zero photos.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentPhotos.count
    }
    
    // Populate the ThumbnailCell custom table view cells.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ThumbnailCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ThumbnailCell", for: indexPath) as! ThumbnailCell
        cell.configure(recentPhoto: recentPhotos[indexPath.row])
        return cell
    }
    
    // MARK - Navigation
    
    // Equivalent of didSelectRowAtIndexPath that goes to the photo detail view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex = self.tableView.indexPath(for: sender as! ThumbnailCell)
        let recentPhoto = recentPhotos[(selectedIndex?.row)!]
        
        // Set the photo in the Photo Detail View Controller to that of the selected cell.
        let photoDetailViewController = segue.destination as! PhotoDetailViewController
        photoDetailViewController.recentPhoto = recentPhoto
        
        // Finally, deselect the selected table view cell with this UITableViewDelegate method.
        tableView.deselectRow(at: selectedIndex!, animated: true)
    }
}

// Implement the FlickrDelegate protocol.
extension ThumbnailTableViewController : FlickrDelegate {
    // Handle the recent photos that were fetched from the Flickr API by reloading the table view
    func handleFetchPhotos(fetchedPhotos: [RecentPhoto]) {
        // Switch back to the main thread, set recentPhotos to the new photos, and reload the table view.
        DispatchQueue.main.async(execute: { () -> Void in
            self.recentPhotos = fetchedPhotos
            self.tableView.reloadData()
        })
    }
    
    // Handle any errors sent from the FlickrService by presenting them in an alert.
    func handleFetchPhotosError(error: FlickrError) {
        // Switch back to the main thread and handle the error by showing alert.
        DispatchQueue.main.async(execute: { () -> Void in
            self.errorAlert(error: error)
        })
    }
}

// Keep the status bar white by setting it on the Navigation Controller.
extension UINavigationController {
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
