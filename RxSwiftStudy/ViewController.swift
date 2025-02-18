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
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: TableViewCell.id, cellType: TableViewCell.self)) { (row, element, cell) in
                
                cell.titleLabel.text = element
                
            }.disposed(by: disposeBag)
        
    }


}

