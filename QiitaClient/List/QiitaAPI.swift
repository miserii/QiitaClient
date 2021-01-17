//
//  QiitaAPI.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/17.
//

import Foundation
import RxSwift

final class QiitaAPI {
    static let shared = QiitaAPI()

    private init() {}

    func fetchArticle(success: @escaping ([QiitaModel]) -> Void) {
        let url = "https://qiita.com/api/v2/items"
        guard var urlComponents = URLComponents(string: url) else { return }

        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
        ]

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            guard let jsonData = data else { return }
            do {
                let articles = try JSONDecoder().decode([QiitaModel].self, from: jsonData)
                success(articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

//QiitaAPIクラスのfunctionをRx対応させる
extension QiitaAPI: ReactiveCompatible {}
extension Reactive where Base: QiitaAPI {
  func fetchArticle(completion: ([QiitaModel]) -> Void) -> Observable<[QiitaModel]> {
    return Observable.create { observer in
        QiitaAPI.shared.fetchArticle(success: { (models) in
//            succesだったらmodelsに入れて購読させる多分
            observer.on(.next(models))
        })
      return Disposables.create()
    }.share()
  }
}
