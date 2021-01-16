//
//  Article.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import Foundation

struct Article: Codable {
    var title: String
    var user: User
    struct User: Codable {
        var name: String
    }
}
