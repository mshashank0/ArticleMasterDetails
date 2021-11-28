//
//  ArticleDetailsViewController.swift
//  FXArticle
//
//  Created by Shashank Mishra on 27/11/21.
//

import UIKit

final class ArticleDetailsViewController: UIViewController {
   
    // MARK: - Properties
    
    var viewModel: ArticleViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    var articles: GroupedArticle?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var displayTimeLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    var selectedReport: SpecialReport? {
        didSet {
            populateValues()
        }
    }
    
    override func viewDidLoad() {
        viewModel?.fetchArticleData()
    }
    
    func setupViewModel(with viewModel: ArticleViewModel) {
        // Configure View Model
        viewModel.didFetchArticleData = { [weak self] (data, error) in
            if let _ = error {
                self?.presentAlert()
            } else if let data = data {
                self?.articles = data
                
                guard let category = self?.articles?.category,
                   category.count > 0,
                   let values = category[0].values.first,
                   values.count > 0 else {
                    return
                }
                self?.selectedReport = values[0]
                DispatchQueue.main.async {
                    self?.populateListVC()
                }
            }
            else {
                self?.presentAlert()
            }
        }
    }
    
    // Alert
    private func presentAlert() {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: "Unable to Get Articles", message: nil, preferredStyle: .alert)

        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // Present Alert Controller
        present(alertController, animated: true)
    }
    
    // We can shift this setup in se[aarte view model
    private func populateValues() {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = self?.selectedReport?.title ?? ""
            if let timeStamp = self?.selectedReport?.displayTimestamp {
                let date = Double(timeStamp).getDateStringFromUTC()
                self?.displayTimeLabel.text = date
            }
            else {
                self?.displayTimeLabel.text = "Latest"
            }
            self?.descriptionLabel.text = self?.selectedReport?.specialReportDescription ?? ""
            self?.descriptionLabel.sizeToFit()
            self?.tagsLabel.text = self?.selectedReport?.categories.joined(separator: ", ")
            self?.urlButton.isHidden = false
        }
        if let url = URL(string: self.selectedReport?.headlineImageURL ?? "") {
            self.headlineImageView.load(url: url)
        }
        
    }
    
    // Populate initial article List view
    private func populateListVC() {
        guard let splitVC = self.splitViewController,
              let articleNavListVC = splitVC.viewControllers[0] as? UINavigationController,
              let articleListVC = articleNavListVC.viewControllers[0] as? ArticleListViewController
              else {
           return
        }
        articleListVC.selectedReport = selectedReport
        articleListVC.articles = articles
    }
    
    @IBAction func openUrl(_ sender: Any) {
        guard let url = URL(string: selectedReport?.url ?? ""),
              UIApplication.shared.canOpenURL(url)
              else { return }
        UIApplication.shared.open(url)
    }

}

extension ArticleDetailsViewController: ArticleSelectionDelegate {
    func articleSelected(_ report: SpecialReport, with title: String) {
        selectedReport = report
        self.navigationItem.title = title
    }
}

