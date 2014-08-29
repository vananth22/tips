//
//  SettingsViewController.swift
//  tips
//
//  Created by Ananth PackkilDurai on 8/28/14.
//  Copyright (c) 2014 Ananth. All rights reserved.
//

import Foundation


import UIKit

class SettingsViewController: UIViewController {
    
    
     let SESSION_DEFAULT_TIP : String = "SESSION_DEFAULT_TIP"
    
    @IBOutlet weak var defaultTipPercentage: UISegmentedControl!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        self.defaultTipPercentage.selectedSegmentIndex = defaults.integerForKey(self.SESSION_DEFAULT_TIP)
        
        
     /*   self.defaultTipPercentage.selectedSegmentIndex = defaults.integerForKey(self.SESSION_DEFAULT_TIP) != nil ? defaults.integerForKey(self.SESSION_DEFAULT_TIP) : 0 */
        
    }


    @IBAction func changeDefaultTips(sender: AnyObject) {
        
        var tipPercentages = [0.18,0.2,0.22]
        var tipAmount = tipPercentages[self.defaultTipPercentage.selectedSegmentIndex]
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(self.defaultTipPercentage.selectedSegmentIndex, forKey: self.SESSION_DEFAULT_TIP)
        defaults.synchronize()
        
        
    }

}
