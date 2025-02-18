//
//  SimpleValidationViewController.swift
//  RxSwiftStudy
//
//  Created by youngkyun park on 2/18/25.
//

import UIKit

import SnapKit

import RxSwift
import RxCocoa

final class SimpleValidationViewController: UIViewController {

    private let userTitle = UILabel()
    private let userNameTextField = UITextField()
    private let userValidationLabel = UILabel()
    
    private let passwordTitle = UILabel()
    private let passwordTextField = UITextField()
    private let passwordValidationLabel = UILabel()
    
    private let button = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configuration()
        bind()
    }
    
    
    private func bind() {
        
        //Observerable 생성
        let usernameVaild = userNameTextField
            .rx
            .text
            .orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1) // share를 통해 구독하고 있는 친구들에게 값을 전달 (reply 버퍼의 수)
        
        let passwordVaild = passwordTextField
            .rx
            .text
            .orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1) // share를 통해 구독하고 있는 친구들에게 값을 전달 (reply 버퍼의 수)
        // 여러개의 Observerable을 생성할 필요가 없음
        
        //유저네임과 패스워드와 조건 확인
        let everythingValid = Observable.combineLatest(usernameVaild, passwordVaild).map { $0 && $1}
        
        usernameVaild
            .bind(to: passwordTextField.rx.isEnabled) //유저네임이 조건이 맞아야 비밀번호 입력 가능
            .disposed(by: disposeBag)
        
        usernameVaild
            .bind(to: userValidationLabel.rx.isHidden) //유저네임 조건이 맞을 경우 안내 레이블 히든
            .disposed(by: disposeBag)
        
        passwordVaild
            .bind(to: passwordValidationLabel.rx.isHidden) //비밀번호 조건이 맞을 경우 안내 레이블 히든
            .disposed(by: disposeBag)
        
        everythingValid.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
        
        button.rx.tap.bind(with: self) { owner, _ in
            let title = "RxExample"
            let msg = "가입에 성공했어요!"
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            owner.present(alert, animated: true)
        }.disposed(by: disposeBag)

        
        
    }

    


}

extension SimpleValidationViewController {
    private func configuration() {
        view.addSubview(userTitle)
        view.addSubview(userNameTextField)
        view.addSubview(userValidationLabel)
        view.addSubview(passwordTitle)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidationLabel)
        view.addSubview(button)
        
        
        userTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
            
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
            
        }
        
        userValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
            
        }
        
        passwordTitle.snp.makeConstraints { make in
            make.top.equalTo(userValidationLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
            
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
            
        }
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
            
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
            
        }
        
        
        userTitle.text  = "Username"
        userTitle.font = .systemFont(ofSize: 17)
        passwordTitle.text  = "Password"
        passwordTitle.font = .systemFont(ofSize: 17)
        
        
        userValidationLabel.text  = "사용자 이름은 최소 5글자 이상입니다."
        userValidationLabel.font = .systemFont(ofSize: 17)
        userValidationLabel.textColor = .red
        passwordValidationLabel.text  = "패스워드는 최소 5글자 이상입니다"
        passwordValidationLabel.font = .systemFont(ofSize: 17)
        passwordValidationLabel.textColor = .red
        
    
        passwordTextField.borderStyle = .roundedRect
        userNameTextField.borderStyle = .roundedRect
        
        passwordTextField.isEnabled = false
        button.isEnabled = false
        button.setTitle("Do SomeThing", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)

    }

}
