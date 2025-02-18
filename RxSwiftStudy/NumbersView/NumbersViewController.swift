//
//  NumbersViewController.swift
//  RxSwiftStudy
//
//  Created by youngkyun park on 2/18/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class NumbersViewController: UIViewController {

    let firstTextField = UITextField()
    let secondTextField = UITextField()
    let thirdTextField = UITextField()
    let imageView = UIImageView()

    let resultLabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        bind()
        view.backgroundColor = .white
    }
    
    private func configuration() {
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(thirdTextField)
        view.addSubview(resultLabel)
        view.addSubview(imageView)
        
        
        firstTextField.snp.makeConstraints { make in
            make.bottom.equalTo(secondTextField.snp.top).offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
        }
        secondTextField.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        thirdTextField.snp.makeConstraints { make in
            make.top.equalTo(secondTextField.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
        }
        imageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.trailing.equalTo(thirdTextField.snp.leading).offset(-10)
            make.top.equalTo(secondTextField.snp.bottom).offset(30)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdTextField.snp.bottom).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(280)
            make.width.equalTo(200)
            make.height.equalTo(50)
            
        }
        imageView.image = UIImage(systemName: "plus")
     
        firstTextField.borderStyle = .roundedRect
        firstTextField.textAlignment = .right
        firstTextField.layer.borderWidth = 5
        secondTextField.borderStyle = .roundedRect
        secondTextField.textAlignment = .right
        secondTextField.layer.borderWidth = 5
        thirdTextField.borderStyle = .roundedRect
        thirdTextField.textAlignment = .right
        thirdTextField.layer.borderWidth = 5

        
    }
    
    
    private func bind() {
        
        // combineLatest 여러개 옵저버들 등록이 가능
        // resultSelector까지 추가 가능
        // firstTextField.rx.text.orEmpty 문자열이 비어있지 않다면
        Observable.combineLatest(firstTextField.rx.text.orEmpty, secondTextField.rx.text.orEmpty, thirdTextField.rx.text.orEmpty) { value, value2, value3 -> Int in
            return (Int(value) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }.map { $0.description } // Int -> String으로 변환
        .bind(to: resultLabel.rx.text) // 텍스트에 값 바로 대입
        .disposed(by: disposeBag)
        
  
    }
        
            
    
}
    

  


