//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterViewControllerDelegate {
    //var client: YelpClient!
    //var businessesArray: NSMutableArray!
    //var businessesArray:[Business] = []
    //@IBOutlet weak var tableView: UITableView!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys

    //new keys for siyu
    
    let yelpConsumerKey = "<api key>"
    let yelpConsumerSecret = "<api key>"
    let yelpToken = "<api key>"
    let yelpTokenSecret = "<api key>"
    
    var client: YelpClient!
    var businessesArray:[Business] = []
    @IBOutlet weak var tableView: UITableView!
    
    var mySearchBar: UISearchBar!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "Business_Cell")

        //the navigation controller
        self.mySearchBar = UISearchBar()
        self.mySearchBar.delegate = self
        self.navigationItem.titleView = mySearchBar
        
        //add filterButton
        var b = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "onFilterButton")
        self.navigationItem.leftBarButtonItem = b
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.title = "Yelp"
        
        self.doYelpSearch("Thai", params: [:])
    }
    
    
    func doYelpSearch ( searchTerm : String, params : NSDictionary ) {
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        businessesArray = []
        
        client.searchWithTerm(searchTerm, params: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //this worked: println(response["businesses"])
            if var responseData = response as? NSDictionary {
                var responseBusinessesArray = responseData["businesses"] as NSArray
                
                for responseBusiness in responseBusinessesArray {
                    var newBusiness = Business(resultsDict: responseBusiness as NSDictionary)
                    self.businessesArray.append(newBusiness)
                }
            }
            
            self.tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // pragma mark - Table view methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businessesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Business_Cell") as BusinessCell
        cell.setBusiness(self.businessesArray[indexPath.row])
        return cell
    }
    
    // pragma mark - search bar functions
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.doYelpSearch(searchBar.text, params:[:])
        self.tableView.reloadData()
    }
    
    func onFilterButton() {
        var fvc = FilterViewController()
        fvc.delegate = self 
        var nvc = UINavigationController(rootViewController: fvc)
        self.presentViewController( nvc, animated: true, completion: nil)
    }
    
    // pragma mark - FilterViewController delegate functions
    func didChangeFilters(filterViewController: FilterViewController, filters : NSDictionary) {
        self.doYelpSearch("Restaurants", params: filters)
    }
    
}

