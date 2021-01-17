//
//  ViewController.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import UIKit
import RxSwift
import RxCocoa

final class QiitaListViewController: UIViewController {

    enum Const {
        static let cellHeight: CGFloat = 90
    }

    private let disposeBag = DisposeBag()
    private let viewModel = QiitaViewModel()
    private lazy var output: QiitaViewModelOutput = viewModel


    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "QiitaListTableViewCell", bundle: nil), forCellReuseIdentifier: "QiitaListTableViewCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    //        この中で必要なストリームを決める
    override func viewDidLoad() {
        super.viewDidLoad()
        //        outputのストリームを決める
        bindOutputStream()
    }

    //viewModelからくるストリーム
    private func bindOutputStream() {
        //outputのmodelsに変化があったというストリームが流れてきたらtableViewを更新
        output.changeModelsObservable.subscribeOn(MainScheduler.instance).subscribe(onNext: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension QiitaListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.models.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Const.cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let qiitaModel = output.models[safe: indexPath.item],
            let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaListTableViewCell", for: indexPath) as? QiitaListTableViewCell
        else { return UITableViewCell() }
        cell.configure(qiitaModel: qiitaModel)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        webViewにせんいするようにする
    }

}
