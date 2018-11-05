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
    /*
    Alamofire.request(.GET, FLICKR_URL, parameters: ["method": SEARCH_METHOD, "api_key": FLICKR_API_KEY, "tags":searchTextField.text,"privacy_filter":PRIVACY_FILTER, "format":FORMAT_TYPE, "nojsoncallback": JSON_CALLBACK])
    .responseJSON { (request, response, data, error) in
    println(request)
    
    if(data != nil){
    
    var json:JSON = JSON(data!)
    var innerJson:JSON = JSON(data!)
    
    var farm:String = innerJson["photos"]["photo"][random]["farm"].stringValue
    var server:String = innerJson["photos"]["photo"][random]["server"].stringValue
    var photoID:String = innerJson["photos"]["photo"][random]["id"].stringValue
    
    var secret:String = innerJson["photos"]["photo"][random]["secret"].stringValue
    
    var imageString:String = "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_n.jpg/"
    println(imageString)
    self.urlToImageView(imageString)
    
    
    }
    }
    
}*/
    // Make a REST GET call to the Flickr API.
    func fetchPhotosFromFlickrAPI(completion: @escaping ([RecentPhoto]?, FlickrError?) -> Void) {
        // Alamofire replaces NSURLSession for purposes of efficiency.
        /*Alamofire.request("https://openexchangerates.org/api/latest.json?app_id=\(appId)").responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let swiftyJSON = JSON(responseData.result.value!)
                
                // Retrieve the Unix timestamp and convert it to formatted date.
                let timestamp = swiftyJSON["timestamp"].double
                let date = Date(timeIntervalSince1970: timestamp!)
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let dateString = dateFormatter.string(from: date)
                
                // Retrieve currency names and exchange rates.
                let ratesJSON = JSON(swiftyJSON["rates"])
                var jsonArray = [Currency]()
                
                for (key, value) in ratesJSON {
                    let aCurrency = Currency(name: key, dateString:dateString, exchangeRate: value.doubleValue)
                    jsonArray.append(aCurrency)
                }
                
                self.currencyArray = jsonArray.sorted(by: { $0.name < $1.name })
                
                if self.currencyArray.count > 0 {
                    self.tableView.reloadData()
                }
            }
                
            else { // Alert user when unable to connect to server.
                let alertController = UIAlertController(title: "Error", message:
                    "Unable to connect to server", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }*/
        print(FlickrConstants.URLString)
        Alamofire.request(FlickrConstants.URLString).responseData(completionHandler: { (response) in
            switch response.result { // success or failure
            case .success: // response was successful
                if let jsonData = response.data {
                    do {
                        // Use JSONDecoder to parse and map JSON into the FlickrPhotos model.
                        let jsonDecoder = JSONDecoder()
                        
                        let flickrPhotos = try jsonDecoder.decode(FlickrPhotos.self, from: jsonData) // FlickrPhotos implements the Codable protocol.
                        
                        // Check the status of the Flickr API
                        if flickrPhotos.stat == "ok" {
                            let recentPhotos = flickrPhotos.photos.photo
                            completion(recentPhotos, nil)
                        }
                        
                        else {
                            completion(nil, FlickrError.FlickrAPIError)
                        }
                    } catch { // JSON was unable to be decoded, which means that the JSON was blank or changed.
                        completion(nil, FlickrError.InvalidJSONData)
                    }
                }
                else {
                    completion(nil, FlickrError.NoDataResponse)
                }
            case .failure(let error): // Alert user when unable to connect to server.
                print(error)
                completion(nil, FlickrError.UnableToConnectToServer)
            }
        })
    }
}
