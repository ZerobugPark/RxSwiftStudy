//
//  SimpleTableExampleViewController.swift
//  RxSwiftStudy
//
//  Created by youngkyun park on 2/18/25.
//

import UIKit

import SnapKit

import RxSwift
import RxCocoa

final class SimpleTableExampleViewController: UIViewController {

    private let tableView = UITableView()
    

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configruation()
        bind()
    }
    
    private func configruation() {
        view.addSubview(tableView)
        
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        
        tableView.rowHeight = 50
        
        tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.id)
    }
    
    private func bind() {
        
        // 밖에서 쓰면 타입이 맞지 않아서 오류가 나네.
        let items = Observable.just(
            //배열을 만드는데 0 ~ 19까지의 문자열 배열 생성
            (0..<20).map { "\($0)" }
            
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SimpleTableViewCell.id, cellType: SimpleTableViewCell.self)) { (row, element, cell) in
                // row == indexPath.row
                // element == 배열의 요소
                
                cell.textLabel?.text = "\(element) @ row \(row)"
                
                // cell의 액서서리 설정
                cell.accessoryType = .detailButton
            
            }.disposed(by: disposeBag)
  
        
        //modelSelected는 items 배열의 타입과 동일해야함
        tableView.rx.modelSelected(String.self)
            .bind(with: self) { owner, value in
                
                let title = "RxExample"
                let msg = "Tapped `\(value)`"
                let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alert.addAction(ok)
                
                owner.present(alert, animated: true)
                
                
            }.disposed(by: disposeBag)
        
    
        tableView.rx.itemAccessoryButtonTapped
            .bind(with: self) { owner, indexPath in
                
                let title = "RxExample"
                let msg = "Tapped Detail @ \(indexPath.section),\(indexPath.row)"
                let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alert.addAction(ok)
                
                owner.present(alert, animated: true)
                
                
            }.disposed(by: disposeBag)

        
        
        
        
        
        
        
        // 셀의 인덱스만 가져올 수 있음
        // items 배열에 직접 접근이 불가능 함
//        tableView.rx.itemSelected.bind(with: self) { owner, indexPath in
//            print(indexPath.row)
//        }.disposed(by: disposeBag)
        
        
        
        
        
//        items.subscribe(with: self) { owner , value in
//            print(value)
//        } onError: { owner, error in
//            print("Error")
//        } onCompleted: { owner in
//            print("onCompleted")
//        } onDisposed: { owner in
//            print("onDisposed")
//        }.disposed(by: disposeBag)

        
    }


}
