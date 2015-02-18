//
//  Business.swift
//  Yelp
//
//  Created by Siyu Song on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

//import Cocoa

class Business: NSObject {
    var imageURL: NSString = NSString()
    var name: NSString = NSString()
    var ratingImageUrl : NSString = NSString()
    var numReviews : NSInteger = NSInteger()
    var address : NSString = NSString()
    var categories : NSString = NSString()
    var distance : CGFloat = CGFloat()
    
    convenience init (resultsDict:NSDictionary){
        self.init()
        
        var verbose = false
        
        self.imageURL = resultsDict["image_url"] as NSString
        self.name = resultsDict["name"] as NSString
        self.ratingImageUrl = resultsDict["rating_img_url"] as NSString
        self.numReviews = resultsDict["review_count"] as NSInteger
        
        //getting address
        var categories = resultsDict.valueForKey("categories") as NSArray
        var categoryNames : NSMutableArray = []
        categories.enumerateObjectsUsingBlock({ object, index, stop in
            categoryNames.addObject(object[0])
        })
        self.categories = categoryNames.componentsJoinedByString(", ")

        //gettingdistance
        self.distance = CGFloat(0.0)
        var myDistance = resultsDict["distance"]
        var milesPerMeter: NSNumber = 0.000621371 as NSNumber
        let resultsdistNSNUM = myDistance as NSNumber
        self.distance = CGFloat(resultsdistNSNUM.floatValue * milesPerMeter.floatValue)

        var st_address = "-"
        if (resultsDict.valueForKeyPath("location.address") as NSArray != NSArray()) {
            st_address = resultsDict.valueForKeyPath("location.address")?[0] as NSString
        }
        var neighborhood = "-"
        if let hoodsArray = resultsDict.valueForKeyPath("location.neighborhoods") {
            var neighborhood = hoodsArray[0] as NSString
        }

        self.address = NSString(string: "\(st_address), \(neighborhood)")
        
    }
    
    func printme(){
        println("=================")
        println("    name:\(self.name)")
        println("    imageurl:\(self.imageURL)")
        println("    ratingimgURL:\(self.ratingImageUrl)")
        println("    address:\(self.address)")
        println("    categories:\(self.categories)")
        println("    distance:\(self.distance)")
    }
    
    
}
