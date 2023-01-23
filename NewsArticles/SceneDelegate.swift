//
//  SceneDelegate.swift
//  News Articles
//
//  Created by Aks_dev on 03/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        NetworkMonitor.shared.startMonitoring()
        
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        UIDevice.current.isJailBroken ? coordinator?.showJailBrokenScreen() : coordinator?.start()
        self.window = UIWindow.init(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
