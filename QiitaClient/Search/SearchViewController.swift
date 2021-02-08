//
//  SearchViewController.swift
//  QiitaClient
//
//  Created by 逢坂 美芹 on 2021/01/20.
//

import UIKit

final class SearchViewController: UIViewController {
    enum Const {
        static let cellHeight: CGFloat = 90
    }

    @IBOutlet private weak var searchTableView: UITableView! {
        didSet {
            searchTableView.register(UINib(nibName: "searchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchTableViewCell")
            searchTableView.dataSource = self
            searchTableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Const.cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as? searchTableViewCell

        return cell
    }
}
