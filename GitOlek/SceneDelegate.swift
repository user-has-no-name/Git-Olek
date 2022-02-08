//
//  SceneDelegate.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 04/02/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {

    guard let winScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: winScene)

    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController = UINavigationController()


    if let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "RootVC") as? SearchVC {

      navigationController.viewControllers = [mainVC]

      mainVC.apiService = APIService()

      window?.rootViewController = navigationController
    }

    window?.makeKeyAndVisible()

  }

  func sceneDidDisconnect(_ scene: UIScene) {

  }

  func sceneDidBecomeActive(_ scene: UIScene) {

  }

  func sceneWillResignActive(_ scene: UIScene) {

  }

  func sceneWillEnterForeground(_ scene: UIScene) {

  }

  func sceneDidEnterBackground(_ scene: UIScene) {

  }

}
