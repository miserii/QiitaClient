//
//  QiitaViewModel.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import Foundation
import RxSwift
import RxCocoa

//ViewModelの出力のprotocol
protocol QiitaViewModelOutput {
    var changeModelsObservable: Observable<Void> { get }
    var models: [QiitaModel] { get }
}

final class QiitaViewModel:  QiitaViewModelOutput {

    private let disposeBag = DisposeBag()

    //output pagingの機能ないのでinputは作らない、はず
    private let _changeModelsObservable = PublishRelay<Void>()//todo: なぜかRxCocoaないと使えない
    lazy var changeModelsObservable = _changeModelsObservable.asObservable()
    //最後に取得したデータ
    private(set) var models: [QiitaModel] = []

    //    initで初期化するときにストリームを決める
    init() {
        QiitaAPI.shared.rx.fetchArticle(completion: {models in
            //            print呼ばれてない
            print(models)
        }).map {[weak self] (models) -> Void in
            //最後に得たデータを保存
            self?.models = models
            //値が更新したことを伝えるためだけのストリームを流すのでVoidにする
            return
        }.bind(to: _changeModelsObservable).disposed(by: disposeBag)
    }
}
