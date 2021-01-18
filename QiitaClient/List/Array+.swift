//
//  Array+.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/17.
//

import Foundation

//安全に使えるようにしてるクラッシュを避けのお守り
extension Array {
  subscript (safe index: Int) -> Element? {
    return index >= 0 && index < self.count ? self[index] : nil
  }
}
