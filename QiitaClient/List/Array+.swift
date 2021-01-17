//
//  Array+.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/17.
//

import Foundation
import UIKit

extension Array {
  subscript (safe index: Int) -> Element? {
    return index >= 0 && index < self.count ? self[index] : nil
  }
}
