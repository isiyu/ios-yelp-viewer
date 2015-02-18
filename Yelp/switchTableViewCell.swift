//
//  switchTableViewCell.swift
//  Yelp
//
//  Created by Siyu Song on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol switchTableViewCellDelegate: class {
    func didUpdateValue (switchTableViewCell:UITableViewCell, didUpdateValue: Bool)
}


/*
protocol FilterViewControllerDelegate: class{
func didChangeFilters ( filterViewController: FilterViewController, filters: NSDictionary)
}

*/

class switchTableViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    weak var delegate : switchTableViewCellDelegate?
    var on : Bool!
    
    /*
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setOn (on: Bool, animated:Bool) {
        self.on = on
        //self.filterSwitch.on = self.on
        self.filterSwitch.setOn(on, animated: animated)
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        println("value changed")
        
        delegate?.didUpdateValue(self, didUpdateValue: self.filterSwitch.on )
    }
}
