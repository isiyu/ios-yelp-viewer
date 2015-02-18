//
//  FilterViewController.swift
//  Yelp
//
//  Created by Siyu Song on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class{
    func didChangeFilters ( filterViewController: FilterViewController, filters: NSDictionary)
}


class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, switchTableViewCellDelegate {

    weak var delegate : FilterViewControllerDelegate?
    //var filters:NSDictionary!
    var categories: NSArray!
    var selectedCategories: NSMutableSet!
    
    @IBOutlet weak var filterTableView: UITableView!
    
    override init() {
        super.init(nibName: "FilterViewController", bundle: nil)
        
        //  super.init(nibName: String, bundle: <#NSBundle?#>)
        self.selectedCategories = NSMutableSet()
        self.initCategories()

    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.filters = [:]

        self.filterTableView.delegate = self
        self.filterTableView.dataSource = self
        
        self.filterTableView.registerNib(UINib(nibName: "switchTableViewCell", bundle: nil), forCellReuseIdentifier: "Switch_Cell")
        
        //cancel button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Cancel", style: .Plain , target: self, action: "onCancelButton")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Apply", style: .Plain , target: self, action: "onApplyButton")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // pragma - switch cell methods
    func didUpdateValue(switchTableViewCell: UITableViewCell, didUpdateValue: Bool) {
        NSLog("filter switch update")
        println("fliter switch fired")
        println("\(didUpdateValue)")
        
        
        var indexPath: NSIndexPath = self.filterTableView.indexPathForCell(switchTableViewCell)!
        if (didUpdateValue) {
            self.selectedCategories.addObject(self.categories[indexPath.row])
        }
        else {
            self.selectedCategories.removeObject(self.categories[indexPath.row])
        }
        
        println(self.selectedCategories)
        //tableView.reloadData()
    }
    
    // pragma - table view methods
    
    func tableView(filterTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = filterTableView.dequeueReusableCellWithIdentifier("Switch_Cell") as switchTableViewCell
        
        cell.delegate = self
        
        let categoryDict = self.categories[indexPath.row] as NSDictionary
        cell.filterLabel.text = categoryDict["name"] as NSString
        
        
        let filterOn = selectedCategories.containsObject(categoryDict)
        cell.setOn(filterOn, animated: false)
        
        return cell
    }
    
    func tableView(filterTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    // param - button actions
    func onCancelButton() {
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    func onApplyButton() {
        
        delegate?.didChangeFilters(self, filters: self.filters)
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    // data management
    
    var filters: NSDictionary {
        // returns NSDictionary of all the different filter types
        var filtersD = NSMutableDictionary()
        println("trying to make filters dict")
        if self.selectedCategories.count > 0 {
            
            var filterCategoriesCodes = NSMutableArray()
            for cat in self.selectedCategories{
                let catDict = cat as NSDictionary
                filterCategoriesCodes.addObject( catDict["code"]!)
            }
            let categoryFilter = filterCategoriesCodes.componentsJoinedByString(",")
            
            
            //filtersD.set
            filtersD.setValue(categoryFilter, forKey: "category_filter")
            //= self.selectedCategories
        }
        
        return filtersD
    }
    
    func initCategories (){
        self.categories =
            [
                ["name" : "Afghan", "code": "afghani" ],
                ["name" : "African", "code": "african" ],
                ["name" : "Senegalese", "code": "senegalese" ],
                ["name" : "South African", "code": "southafrican" ],
                ["name" : "American, New", "code": "newamerican" ],
                ["name" : "American, Traditional", "code": "tradamerican" ],
                ["name" : "Arabian", "code": "arabian" ],
                ["name" : "Argentine", "code": "argentine" ],
                ["name" : "Armenian", "code": "armenian" ],
                ["name" : "Asian Fusion", "code": "asianfusion" ],
                ["name" : "Australian", "code": "australian" ],
                ["name" : "Austrian", "code": "austrian" ],
                ["name" : "Bangladeshi", "code": "bangladeshi" ],
                ["name" : "Barbeque", "code": "bbq" ],
                ["name" : "Basque", "code": "basque" ],
                ["name" : "Belgian", "code": "belgian" ],
                ["name" : "Brasseries", "code": "brasseries" ],
                ["name" : "Brazilian", "code": "brazilian" ],
                ["name" : "Breakfast & Brunch", "code": "breakfast_brunch" ],
                ["name" : "British", "code": "british" ],
                ["name" : "Buffets", "code": "buffets" ],
                ["name" : "Burgers", "code": "burgers" ],
                ["name" : "Burmese", "code": "burmese" ],
                ["name" : "Cafes", "code": "cafes" ],
                ["name" : "Cafeteria", "code": "cafeteria" ],
                ["name" : "Cajun/Creole", "code": "cajun" ],
                ["name" : "Cambodian", "code": "cambodian" ],
                ["name" : "Caribbean", "code": "caribbean" ],
                ["name" : "Dominican", "code": "dominican" ],
                ["name" : "Haitian", "code": "haitian" ],
                ["name" : "Puerto Rican", "code": "puertorican" ],
                ["name" : "Trinidadian", "code": "trinidadian" ],
                ["name" : "Catalan", "code": "catalan" ],
                ["name" : "Cheesesteaks", "code": "cheesesteaks" ],
                ["name" : "Chicken Shop", "code": "chickenshop" ],
                ["name" : "Chicken Wings", "code": "chicken_wings" ],
                ["name" : "Chinese", "code": "chinese" ],
                ["name" : "Cantonese", "code": "cantonese" ],
                ["name" : "Dim Sum", "code": "dimsum" ],
                ["name" : "Shanghainese", "code": "shanghainese" ],
                ["name" : "Szechuan", "code": "szechuan" ],
                ["name" : "Comfort Food", "code": "comfortfood" ],
                ["name" : "Corsican", "code": "corsican" ],
                ["name" : "Creperies", "code": "creperies" ],
                ["name" : "Cuban", "code": "cuban" ],
                ["name" : "Czech", "code": "czech" ],
                ["name" : "Delis", "code": "delis" ],
                ["name" : "Diners", "code": "diners" ],
                ["name" : "Fast Food", "code": "hotdogs" ],
                ["name" : "Filipino", "code": "filipino" ],
                ["name" : "Fish & Chips", "code": "fishnchips" ],
                ["name" : "Fondue", "code": "fondue" ],
                ["name" : "Food Court", "code": "food_court" ],
                ["name" : "Food Stands", "code": "foodstands" ],
                ["name" : "French", "code": "french" ],
                ["name" : "Gastropubs", "code": "gastropubs" ],
                ["name" : "German", "code": "german" ],
                ["name" : "Gluten-Free", "code": "gluten_free" ],
                ["name" : "Greek", "code": "greek" ],
                ["name" : "Halal", "code": "halal" ],
                ["name" : "Hawaiian", "code": "hawaiian" ],
                ["name" : "Himalayan/Nepalese", "code": "himalayan" ],
                ["name" : "Hong Kong Style Cafe", "code": "hkcafe" ],
                ["name" : "Hot Dogs", "code": "hotdog" ],
                ["name" : "Hot Pot", "code": "hotpot" ],
                ["name" : "Hungarian", "code": "hungarian" ],
                ["name" : "Iberian", "code": "iberian" ],
                ["name" : "Indian", "code": "indpak" ],
                ["name" : "Indonesian", "code": "indonesian" ],
                ["name" : "Irish", "code": "irish" ],
                ["name" : "Italian", "code": "italian" ],
                ["name" : "Japanese", "code": "japanese" ],
                ["name" : "Ramen", "code": "ramen" ],
                ["name" : "Teppanyaki", "code": "teppanyaki" ],
                ["name" : "Korean", "code": "korean" ],
                ["name" : "Kosher", "code": "kosher" ],
                ["name" : "Laotian", "code": "laotian" ],
                ["name" : "Latin American", "code": "latin" ],
                ["name" : "Colombian", "code": "colombian" ],
                ["name" : "Salvadorean", "code": "salvadorean" ],
                ["name" : "Venezuelan", "code": "venezuelan" ],
                ["name" : "Live/Raw Food", "code": "raw_food" ],
                ["name" : "Malaysian", "code": "malaysian" ],
                ["name" : "Mediterranean", "code": "mediterranean" ],
                ["name" : "Falafel", "code": "falafel" ],
                ["name" : "Mexican", "code": "mexican" ],
                ["name" : "Middle Eastern", "code": "mideastern" ],
                ["name" : "Egyptian", "code": "egyptian" ],
                ["name" : "Lebanese", "code": "lebanese" ],
                ["name" : "Modern European", "code": "modern_european" ],
                ["name" : "Mongolian", "code": "mongolian" ],
                ["name" : "Moroccan", "code": "moroccan" ],
                ["name" : "Pakistani", "code": "pakistani" ],
                ["name" : "Persian/Iranian", "code": "persian" ],
                ["name" : "Peruvian", "code": "peruvian" ],
                ["name" : "Pizza", "code": "pizza" ],
                ["name" : "Polish", "code": "polish" ],
                ["name" : "Portuguese", "code": "portuguese" ],
                ["name" : "Poutineries", "code": "poutineries" ],
                ["name" : "Russian", "code": "russian" ],
                ["name" : "Salad", "code": "salad" ],
                ["name" : "Sandwiches", "code": "sandwiches" ],
                ["name" : "Scandinavian", "code": "scandinavian" ],
                ["name" : "Scottish", "code": "scottish" ],
                ["name" : "Seafood", "code": "seafood" ],
                ["name" : "Singaporean", "code": "singaporean" ],
                ["name" : "Slovakian", "code": "slovakian" ],
                ["name" : "Soul Food", "code": "soulfood" ],
                ["name" : "Soup", "code": "soup" ],
                ["name" : "Southern", "code": "southern" ],
                ["name" : "Spanish", "code": "spanish" ],
                ["name" : "Sri Lankan", "code": "srilankan" ],
                ["name" : "Steakhouses", "code": "steak" ],
                ["name" : "Sushi Bars", "code": "sushi" ],
                ["name" : "Taiwanese", "code": "taiwanese" ],
                ["name" : "Tapas Bars", "code": "tapas" ],
                ["name" : "Tapas/Small Plates", "code": "tapasmallplates" ],
                ["name" : "Tex-Mex", "code": "tex-mex" ],
                ["name" : "Thai", "code": "thai" ],
                ["name" : "Turkish", "code": "turkish" ],
                ["name" : "Ukrainian", "code": "ukrainian" ],
                ["name" : "Uzbek", "code": "uzbek" ],
                ["name" : "Vegan", "code": "vegan" ],
                ["name" : "Vegetarian", "code": "vegetarian" ],
                ["name" : "Vietnamese", "code": "vietnamese" ]
        ]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
