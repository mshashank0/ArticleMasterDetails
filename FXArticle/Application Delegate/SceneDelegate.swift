//
//  SceneDelegate.swift
//  dsadasd
//
//  Created by Shashank Mishra on 27/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else {
            return
        }
        guard
          let splitViewController = window?.rootViewController as? UISplitViewController,
          let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
          let articleListViewController = leftNavController.viewControllers.first as? ArticleListViewController,
          let articleDetailViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? ArticleDetailsViewController
          else { fatalError() }

        let firstArticle = articleListViewController.articles?.category.first?.values.first
        articleDetailViewController.selectedReport = firstArticle?.first
        // Initialize Article View Model
        let articleViewModel = ArticleViewModel(networkService: NetworkManager())
        // Configure Article Details View Controller
        articleDetailViewController.viewModel = articleViewModel
        articleListViewController.delegate = articleDetailViewController
    }
}


