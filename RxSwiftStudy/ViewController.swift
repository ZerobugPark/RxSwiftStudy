//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by youngkyun park on 2/18/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    private let tableView = UITableView()
    
    let items = Observable.just([
        "SimpleTable",
        "NumbersView",
        "SimpleValidation",
        "BirthDayView"
    ])
    
    
    
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
        
        
        tableView.rowHeight = 100
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
    }
    
    private func bind() {
        
        // bind(to:) 옵저버에 새로운 옵저버블을 추가할 때 사용하는 듯
        items
            .bind(to: tableView.rx.items(cellIdentifier: TableViewCell.id, cellType: TableViewCell.self)) { (row, element, cell) in
                
                cell.titleLabel.text = element
                
            }.disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.bind(with: self) { owner, indexPath in
            
            if indexPath.item == 0 {
                let vc = SimpleTableExampleViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.item == 1 {
                let vc = NumbersViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.item == 2 {
                let vc = SimpleValidationViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = BirthDayViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }
        .disposed(by: disposeBag)
        
    }
   


}

