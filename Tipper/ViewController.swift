//
//  ViewController.swift
//  Tipper
//
//  Created by Ramya Baratam on 8/24/15.
//  Copyright (c) 2015 Ramya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipController: UISegmentedControl!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipInfo: UIView!
    @IBOutlet weak var customLabel: UITextField!
    
    
    var tipViewHasAppeared = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmount.tintColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0)
        
        billAmount.becomeFirstResponder()
        
        tipInfo.hidden = true
        customLabel.hidden = true
        
        tipAmount.text = "$0.00"
        totalAmount.text = "$0.00"
        
        tipController.selectedSegmentIndex = 1
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {

        var billValue = NSString(string:billAmount.text).doubleValue
        var tip: Double = 0.0
        var customPercentage = NSString(string: customLabel.text).doubleValue
        
        // to have the tip info appear when user types and also to appear only once
        if !tipViewHasAppeared {
            tipInfo.alpha = 0
            tipInfo.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.tipInfo.alpha = 1
            })
            tipViewHasAppeared = true
        }
        
        //switch case to handle the different tabs
        
        switch (tipController.selectedSegmentIndex) {
        case 0:
            tipPercentageLabel.hidden = false
            customLabel.hidden = true
            tip = billValue * 0.10
            tipPercentageLabel.text = "10"
        case 1:
            tipPercentageLabel.hidden = false
            customLabel.hidden = true
            tip = billValue * 0.15
            tipPercentageLabel.text = "15"
        case 2:
            tipPercentageLabel.hidden = false
            customLabel.hidden = true
            tip = billValue * 0.20
            tipPercentageLabel.text = "20"
        case 3:
            tipPercentageLabel.hidden = true
            customLabel.hidden = false
            customLabel.becomeFirstResponder()
            tip = billValue * (customPercentage/100)
            tipPercentageLabel.text = "\(customPercentage)"
        default:
            break;
        }
        
        var total = billValue + tip
        
        tipAmount.text = "$\(tip)"
        totalAmount.text = "$\(total)"
       
        
        tipAmount.text = NSString(format: "$%.2f", tip) as String
        totalAmount.text = NSString(format: "$%.2f", total) as String
        //tipPercentageLabel.text = NSString(format: "%.2f", customPercentage) as String
    
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (range.length + range.location > count(textField.text) )
        {
            return false;
        }
        
        let newLength = count(textField.text) + count(string) - range.length
        return newLength <= 2
    }
}

