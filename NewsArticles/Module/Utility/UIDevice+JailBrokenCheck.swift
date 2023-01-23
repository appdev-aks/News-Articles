//
//  UIDevice+JailBrokenCheck.swift
//  NewsArticles
//
//  Created by Akshay Pure on 23/01/23.
//

import Foundation
import UIKit

extension UIDevice {
    
    var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    var isJailBroken: Bool {
        if UIDevice.current.isSimulator { return false }
        if JailBrokenHelper.hasCydiaInstalled() { return true }
        return JailBrokenHelper.canEditSystemFiles()
    }
}

public struct JailBrokenHelper {
    static func hasCydiaInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    static func canEditSystemFiles() -> Bool {
        let jailBreakText = "Writing file.."
        do {
            try jailBreakText.write(toFile: jailBreakText, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
}
