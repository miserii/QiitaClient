//
//  QiitaListTableViewCell.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import UIKit

final class QiitaListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userName: UILabel!

    func configure(qiitaModel: QiitaModel) {
      title.text = qiitaModel.title
      userName.text = qiitaModel.user.name
    }
}
