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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
