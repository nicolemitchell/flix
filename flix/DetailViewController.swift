//
//  DetailViewController.swift
//  flix
//
//  Created by Nicole Mitchell on 6/16/16.
//  Copyright © 2016 Nicole Mitchell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var viewSpace: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var movie: NSDictionary!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.

        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.origin.y + viewSpace.frame.size.height)
        
        let title = movie["title"] as? String
        titleLabel.text = title
        
        print("scroll view: \(scrollView.frame.size)")
        print("view : \(view.frame.size)")
        print("viewSpace : \(viewSpace.frame.size)")
        
        let overview = movie["overview"] as? String
        overviewLabel.text = overview
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String {
            let imageUrl = NSURL(string: baseUrl + posterPath)
            
            
            
            let imageRequest = NSURLRequest(URL: imageUrl!)
            
            self.posterImageView.setImageWithURLRequest(
                imageRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        self.posterImageView.alpha = 0.0
                        self.posterImageView.image = image
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.posterImageView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        self.posterImageView.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        print("prepare for segue called")
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
