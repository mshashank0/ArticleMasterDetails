//
//  ArticleListViewController.swift
//  FXArticle
//
//  Created by Shashank Mishra on 27/11/21.
//

import UIKit

protocol ArticleSelectionDelegate {
    func articleSelected(_ report: SpecialReport, with title: String)
}

final class ArticleListViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView?
    
    var delegate: ArticleSelectionDelegate?
    
    var selectedReport: SpecialReport? {
        didSet {
           tableView?.reloadData()
        }
    }
    var articles: GroupedArticle? {
        didSet {
           tableView?.reloadData()
        }
    }

}

//MARK:- UITableView Data Source
extension ArticleListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles?.category.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.category[section].values.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
           view.backgroundColor = UIColor.black
           let lbl = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width - 16, height: 44))
           lbl.font = UIFont.boldSystemFont(ofSize: 18)
           lbl.textColor = UIColor.white
           lbl.text = articles?.category[section].keys.first?.rawValue
           view.addSubview(lbl)
           return view
         }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        cell.textLabel?.text = articles?.category[indexPath.section].values.first?[indexPath.row].title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}

//MARK:- UITableView Delegates
extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedReport = articles?.category[indexPath.section].values.first?[indexPath.row]
        guard let _selectedReport = selectedReport else {
            return
        }
        delegate?.articleSelected(_selectedReport, with: articles?.category[indexPath.section].keys.first?.rawValue ?? "")
        if
          let detailViewController = delegate as? ArticleDetailsViewController,
          let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

