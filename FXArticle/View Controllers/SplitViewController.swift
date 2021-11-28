//
//  SplitViewController.swift
//  FXArticle
//
//  Created by Shashank Mishra on 28/11/21.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

  override func viewDidLoad() {
      super.viewDidLoad()
      self.delegate = self
  }

  func splitViewController(
      _ splitViewController: UISplitViewController,
      collapseSecondary secondaryViewController: UIViewController,
      onto primaryViewController: UIViewController) -> Bool {
    // Return true to prevent UIKit from applying its default behavior
      return true
  }
}
