//
//  QiitaModel.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import Foundation

final class QiitaModel {

    func fetchArticle(completion: @escaping ([Article]) -> Void) {

        let url = "https://qiita.com/api/v2/items"
        guard var urlComponents = URLComponents(string: url) else { return }

        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
        ]

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            guard let jsonData = data else { return }
            do {
                let articles = try JSONDecoder().decode([Article].self, from: jsonData)
                completion(articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}