//
//  JailBrokenDeviceDetectedViewController.swift
//  NewsArticles
//
//  Created by Akshay Pure on 23/01/23.
//

import Foundation
import UIKit

class JailBrokenDeviceDetectedViewController: UIViewController {
    var coordinator: MainCoordinator?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleSubLabel: UILabel!

    override func viewDidLoad() {
        setupUIElements()
    }
    
    func setupUIElements() {
        titleLabel.text = Localization.JailBroken.jailBrokenTitle
        titleSubLabel.text = Localization.JailBroken.jailBrokenSubTitle
    }
    
    @IBAction func closeApp(_ sender: Any) {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
}
