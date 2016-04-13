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
    @IBOutlet weak var btnStart: NSButton!
    @IBOutlet weak var btnStop: NSButton!
    @IBOutlet weak var btnPause: NSButton!
    let c = Controls()
    
    @IBAction func btnPause(sender: AnyObject) {
        c.pauseTimer()
        btnStart.hidden = false
        btnPause.hidden = true
    }
    
    @IBAction func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBAction func btnStopTimer(sender: AnyObject) {
        c.stopTimer()
        btnStart.hidden = false
        btnPause.hidden = true
    }
    
    @IBAction func btnReload(sender: AnyObject) {
        count = defaults.integerForKey("count");
        c.stopTimer()
        c.startTimer()
        btnStart.hidden = true
        btnPause.hidden = false
    }
    
    @IBAction func btnStart(sender: AnyObject) {
        c.startTimer()
        btnStart.hidden = true
        btnPause.hidden = false
    }
    
    @IBAction func btnChange(sender: AnyObject) {
        let v = c.timeToSeconds(txtTime.stringValue)
        defaults.setInteger(v, forKey: "count")
        //        defaults.setObject(txtMessage.stringValue, forKey: "message")
        count = v
        c.stopTimer()
        c.startTimer()
        btnStart.hidden = true
        btnStop.hidden = false
        txtTime.stringValue = String(c.timeToString(defaults.integerForKey("count")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTime.placeholderString = String(c.timeToString(defaults.integerForKey("count")))
        // Do view setup here.
    }
    
    
    
    
}
