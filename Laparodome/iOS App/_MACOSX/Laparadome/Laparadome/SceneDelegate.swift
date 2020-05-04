//
//  SceneDelegate.swift
//  Laparadome
//
//  Created by Sam Wu on 4/11/20.
//  Copyright © 2020 Sam Wu. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let vc = TaskSelectionViewController()
        let navController = UINavigationController(rootViewController: vc)
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    
}

