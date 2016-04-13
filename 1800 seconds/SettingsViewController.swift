//
//  SettingsViewController.swift
//  1800seconds
//
//  Created by Ivan Lazarevic on 4/12/16.
//  Copyright © 2016 Ivan Lazarevic. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {
    @IBOutlet weak var lblTime: NSTextField!
    @IBOutlet weak var txtTime: NSTextField!
    @IBOutlet weak var txtMessage: NSTextField!
    let defaults = NSUserDefaults.standardUserDefaults()
        
    @IBAction func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBAction func btnChange(sender: AnyObject) {
        let v = Int(txtTime.stringValue)
        defaults.setInteger(v!, forKey: "count")
        //        defaults.setObject(txtMessage.stringValue, forKey: "message")
        count = v!
    }
    
    @IBAction func btnReload(sender: AnyObject) {
        count = defaults.integerForKey("count");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTime.placeholderString = String(defaults.integerForKey("count"));
        // Do view setup here.
    }
    
    
}
