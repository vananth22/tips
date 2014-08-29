//
//  ViewController.swift
//  tips
//
//  Created by Ananth PackkilDurai on 8/27/14.
//  Copyright (c) 2014 Ananth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
   
    
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
    @IBOutlet weak var billField: UITextField!
   
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var twoTotalLabel: UILabel!
    
    
    @IBOutlet weak var threeTotalLabel: UILabel!
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    let SESSION_DATE_TIME : String = "SESSION_DATE_TIME"
    
    let SESSION_BILL_AMOUNT : String = "SESSION_BILL_AMOUNT"
    
    let SESSION_DEFAULT_TIP : String = "SESSION_DEFAULT_TIP"
    
    let DEFAULT_AMOUNT : String = "$0.00"
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = self.DEFAULT_AMOUNT
        totalLabel.text = self.DEFAULT_AMOUNT
        
        var defaults = NSUserDefaults.standardUserDefaults()

        
        self.manage(defaults)  // manage the cookie and remove when we need to
        
        
        var defaultTipIndex = defaults.integerForKey(self.SESSION_DEFAULT_TIP)
        
        var billTextAmount = defaults.objectForKey(self.SESSION_BILL_AMOUNT) != nil ? defaults.objectForKey(self.SESSION_BILL_AMOUNT) as String : ""
        
        
        
        
        self.tipControl.selectedSegmentIndex = defaultTipIndex
        
        self.billField.text = billTextAmount
        
        self.onEditingChanged(self)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.billField.text, forKey: self.SESSION_BILL_AMOUNT)
        defaults.synchronize();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let tipPercentages = [0.18,0.2,0.22]
        
        let tipAmount = tipPercentages[self.tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: self.billField.text).doubleValue
        
        let tips = billAmount * tipAmount
        
        let totalAmount = billAmount + tips
        
        self.totalLabel.text = String(format: "$%.2f", totalAmount)
        self.tipLabel.text = String(format: "$%.2f", tips)
        
        self.twoTotalLabel.text = String(format: "$%.2f", totalAmount / 2)
        
        self.threeTotalLabel.text = String(format: "$%.2f", totalAmount / 3)

        
        
    }
    
    
    /*
        Keep track of the session timing and disable it. Wonder why there is no Time To Live Attribute!!!!
    */
    func manage(userDefaults : NSUserDefaults) {
        
        if(userDefaults.objectForKey(self.SESSION_DATE_TIME) != nil) {
            
            let sessionDate = userDefaults.objectForKey(self.SESSION_DATE_TIME) as NSDate
            
            let interval = NSDate().timeIntervalSinceDate(sessionDate)
            
            println(interval)
            
            if(interval > 1000) {
                self.removeUserDefaults(userDefaults)
                println("removed")
            }
           
            
        } else {
            
            let currentTime = NSDate()
            userDefaults.setObject(currentTime, forKey: self.SESSION_DATE_TIME)
            userDefaults.synchronize()
            
        }
        
        
    }
    
    
    func removeUserDefaults(userDefaults : NSUserDefaults) {
        
        userDefaults.removeObjectForKey(self.SESSION_DATE_TIME)
        
        userDefaults.removeObjectForKey(self.SESSION_BILL_AMOUNT)
        
        userDefaults.removeObjectForKey(self.SESSION_DEFAULT_TIP)
        
        
    }
    
    
    
    /**
        Hide the keyboard by telling the device editing is done.
    
    */
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
        
        
    }
    
    
    
    @IBAction func showSettings(sender: AnyObject) {
        
        println("settings clicked")
        
    }
    
}

