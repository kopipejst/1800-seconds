//
//  AppDelegate.swift
//  1800seconds
//
//  Created by Ivan Lazarevic on 4/11/16.
//  Copyright © 2016 Ivan Lazarevic. All rights reserved.
//

import Cocoa

var count = 0
var timer: NSTimer?
var statusBar = NSStatusBar.systemStatusBar()
var statusBarItem : NSStatusItem = NSStatusItem()
let defaults = NSUserDefaults.standardUserDefaults()

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    override func awakeFromNib() {
        //Add statusBarItem
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.action = Selector("togglePopover:")
        statusBarItem.title = "1800 seconds"
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        //        self.window!.orderOut(self)
        
        popover.contentViewController = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        
        let c = Controls()
        c.startTimer()
        
        if (defaults.integerForKey("count") == 0) {
            defaults.setInteger(1800, forKey: "count")
            defaults.setValue("Take a break !", forKey: "message")
        }
        count = defaults.integerForKey("count")
        
        eventMonitor = EventMonitor(mask:[.LeftMouseDownMask, .RightMouseDownMask]) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
        
    func showPopover(sender: AnyObject?) {
        if let button = statusBarItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
}

