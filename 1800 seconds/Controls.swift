//
//  Controls.swift
//  1800 seconds
//
//  Created by Ivan Lazarevic on 4/13/16.
//  Copyright © 2016 Ivan Lazarevic. All rights reserved.
//

import Foundation

class Controls:NSObject {
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    func stopTimer() {
        timer?.invalidate()
        count = defaults.integerForKey("count")
        update()
    }
    
    func update() {
        if (count > 0) {
            let t = timeToString(count--, format: "short")
            statusBarItem.title = t
        } else {
            showNotification()
            count = defaults.integerForKey("count")
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func timeToString (seconds : Int, format: String = "long") -> String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = (seconds % 3600) % 60
        
        var t = NSString(format: "%02d:%02d:%02d", h, m, s) as String
        
        if (format == "short" && h == 0) {
            t = NSString(format: "%02d:%02d", m, s) as String
        }
        
        return t
        
    }
    
    func timeToSeconds (time : String) -> Int {
        let t = time.componentsSeparatedByString(":")

        var h = 0
        var m = 0
        var s = 0
        
        if (t.count == 3) {
            h = Int(t[0])!
            m = Int(t[1])!
            s = Int(t[2])!
        }
        
        if (t.count == 2) {
            m = Int(t[0])!
            s = Int(t[1])!
        }
        
        if (t.count == 1) {
            s = Int(t[0])!
        }
        
        return h * 3600 + m * 60 + s
    }
    
    func showNotification() -> Void {
        let notification = NSUserNotification()
        notification.title = "1800 seconds"
        notification.informativeText = "Take a break !"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
    
}
