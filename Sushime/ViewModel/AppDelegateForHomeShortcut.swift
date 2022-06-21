//
//  AppDelegateForHomeShortcut.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 21/06/22.
//

import SwiftUI
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    let configuration = UISceneConfiguration(
      name: "Main Scene",
      sessionRole: connectingSceneSession.role
    )
    configuration.delegateClass = MainSceneDelegate.self
    return configuration
  }
}

final class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {
  @Environment(\.openURL) private var openURL: OpenURLAction
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionptions: UIScene.ConnectionOptions){
        guard let shortcutItem = connectionptions.shortcutItem else {
            return
    }
    
    handleShortcutItem(shortcutItem)
  }
  
  func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void
  ) {
    handleShortcutItem(shortcutItem, completionHandler: completionHandler)
  }
  
  private func handleShortcutItem(
    _ shortcutItem: UIApplicationShortcutItem,
    completionHandler: ((Bool) -> Void)? = nil
  ) {
    guard shortcutItem.type == "createTable" else {
        if let completionHandler = completionHandler {
            completionHandler(false)
        }
      return
    }
    
    openURL(URL(string: "sushime://create/")!) { completed in
        if let completionHandler = completionHandler {
            completionHandler(completed)
        }
    }
  }
}
