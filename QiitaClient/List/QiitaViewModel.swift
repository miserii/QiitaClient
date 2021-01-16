//
//  QiitaViewModel.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import Foundation
import RxSwift

final class QiitaViewModel {

    private let qiitaModel = QiitaModel()
    private let disposeBag = DisposeBag()
//    こっちでtext情報
    private let articles: Observable<[Article]>
//    こっちでリロード通知？
    private(set) var reloadData: Observable<Void>
    
    init() {
        

    }
}
