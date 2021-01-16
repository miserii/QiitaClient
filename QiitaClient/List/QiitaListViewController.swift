//
//  ViewController.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import UIKit
import RxSwift

final class QiitaListViewController: UIViewController {

    enum Const {
        static let cellHeight: CGFloat = 75
    }

    private let qiitaViewModel = QiitaViewModel()
    private let disposeBag = DisposeBag()
    fileprivate var articles: [Article] = []

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "QiitaListTableViewCell", bundle: nil), forCellReuseIdentifier: "QiitaListTableViewCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func addRxObserver() {
        qiitaViewModel.fetchArticle(completion: { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

}

extension QiitaListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Const.cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaListTableViewCell", for: indexPath) as! QiitaListTableViewCell
        let article = articles[indexPath.row]
        cell.title?.text = article.title
        cell.userName?.text = article.user.name

        return cell
    }
}


