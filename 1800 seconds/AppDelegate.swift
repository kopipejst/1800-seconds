//
//  AppDelegate.swift
//  1800seconds
//
//  Created by Ivan Lazarevic on 4/11/16.
//  Copyright © 2016 Ivan Lazarevic. All rights reserved.
//

import Cocoa

var count = 0

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let popover = NSPopover()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    
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
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
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
    
    func update() {
        if (count > 0) {
            let (h,m,s) = secondsToHoursMinutesSeconds(count--)
            var t = NSString(format: "%02d:%02d", m, s) as String
            if (h > 0) {
                t = NSString(format: "%02d:%02d:%02d", h, m, s) as String
            }
            statusBarItem.title = t
        } else {
            showNotification()
            count = defaults.integerForKey("count")
        }
    }
    
    func showNotification() -> Void {
        let notification = NSUserNotification()
        notification.title = "1800 seconds"
        notification.informativeText = "Take a break !"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
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

