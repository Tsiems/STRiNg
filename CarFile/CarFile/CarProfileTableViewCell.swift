//
//  CarProfileTableViewCell.swift
//  CarFile
//
//  Created by Travis Siems on 11/27/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class CarProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func load_image(urlString:String)
//    {
//        
//        var imgURL: NSURL = NSURL(string: urlString)!
//        let request: NSURLRequest = NSURLRequest(URL: imgURL)
//        NSURLConnection.sendAsynchronousRequest(
//            request, queue: NSOperationQueue.mainQueue(),
//            completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
//                if error == nil {
//                    self.profilePicture.image = UIImage(data: data!)
//                }
//        })
//        
//    }
    
//    func loadImage(urlString:String) {
//        
//        if let imageURL = NSBundle.mainBundle().URLForResource("https://media.ed.edmunds-media.com/hyundai/accent/2013/oem/2013_hyundai_accent_sedan_gls_s_oem_2_423.jpg", withExtension: "jpg"), let data = NSData(contentsOfURL: imageURL), let image = UIImage(data: data) {
//            print( "Assigning image" )
//            profilePicture.contentMode = .ScaleAspectFit
//            profilePicture.image = image
//            
//        }
//    }
    
    func loadImage(urlString:String)
    {
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if (error == nil && data != nil)
            {
                func display_image()
                {
                    self.profilePicture.image = UIImage(data: data!)
                }
                
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
            
        }
        
        task.resume()
    }

}
