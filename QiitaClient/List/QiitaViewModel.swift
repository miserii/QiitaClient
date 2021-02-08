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
protocol QiitaViewModelInput {
    var qiitaArticleObserver: AnyObserver<Void> { get }
}

protocol QiitaViewModelOutput {
    var changeModelsObservable: Observable<Void> { get }
    var models: [QiitaModel] { get }
}

final class QiitaViewModel:  QiitaViewModelInput, QiitaViewModelOutput {

    private let disposeBag = DisposeBag()

    //input
    private let _qiitaArticleObserver = PublishSubject<Void>()
    private(set) lazy var qiitaArticleObserver: AnyObserver<Void> = _qiitaArticleObserver.asObserver()

    //output
    private let _changeModelsObservable = PublishRelay<Void>()
    private(set) lazy var changeModelsObservable = _changeModelsObservable.asObservable()
    //最後に取得したデータ
    private(set) var models: [QiitaModel] = []

    //    initで初期化するときにストリームを決める
    init() {
        //ストリームに値がきたらAPIを叩いて
        //出力に値を保存して,出力にストリームを流す

        _qiitaArticleObserver
            .flatMapLatest({ (completion) -> Observable<[QiitaModel]> in
                QiitaAPI.rx.fetchArticle
            })
            .map { [weak self] (models) -> Void in
                //最後に得たデータを保存
                self?.models = models
                //値が更新したことを告げるためだけのストリームを流すのでVoidにする
                return
            }
            .bind(to: _changeModelsObservable)
            .disposed(by: disposeBag)
    }
}
