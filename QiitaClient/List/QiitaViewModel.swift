//
//  QiitaViewModel.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/16.
//

import Foundation
import RxSwift
import RxCocoa

//ViewModelの出力に関するprotocol
protocol QiitaViewModelOutput {
    var changeModelsObservable: Observable<Void> { get }
    var models: [QiitaModel] { get }
}

final class QiitaViewModel:  QiitaViewModelOutput {

    private let disposeBag = DisposeBag()

    //input
//    private let _searchText = PublishRelay<String>()
//    lazy var searchTextObserver: AnyObserver<String> = .init(eventHandler: { (event) in
//        guard let e = event.element else { return }
//        self._searchText.accept(e)
//    })
    //output
    private let _changeModelsObservable = PublishRelay<Void>()
    lazy var changeModelsObservable = _changeModelsObservable.asObservable()
    //最後に取得したデータ
    private(set) var models: [QiitaModel] = []

    //    初期化するときにストリームを決める
    init() {
        //ストリームに値がきたらAPIを叩いて
        //出力に値を保存して,出力にストリームを流す
//                Observable<Any>.combineLatest(
//                    _searchText
//                ).flatMapLatest({ (searchWord) -> Observable<[QiitaModel]> in
//                    QiitaAPI.shared.rx.fetchArticle(completion: {models in
//                        print(models)
//                    })
//                }).map {[weak self] (models) -> Void in
//                    //最後に得たデータを保存
//                    self?.models = models
//                    //値が更新したことを告げるためだけのストリームを流すのでVoidにする
//                    return
//                }.bind(to: _changeModelsObservable).disposed(by: disposeBag)

        QiitaAPI.shared.rx.fetchArticle(completion: {models in
            print(models)
        })
    }
}
