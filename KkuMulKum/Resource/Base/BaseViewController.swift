//
//  BaseViewController.swift
//  KkuMulKum
//
//  Created by 김진웅 on 7/3/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
        setupAction()
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// 네비게이션 바 등 추가적으로 UI와 관련한 작업
    func setupView() {}
    
    /// RootView로부터 액션 설정 (addTarget)
    func setupAction() {}
    
    /// RootView 또는 ViewController 자체로부터 Delegate, DateSource 등 설정
    func setupDelegate() {}
}

extension BaseViewController {
    /// 네비게이션 바 타이틀 설정
    final func setupNavigationBarTitle(with string: String) {
        title = string
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.gray8,
            .font: UIFont.pretendard(.body03)
        ]
        
        let lineView = UIView(backgroundColor: .gray2)
        navigationController?.navigationBar.addSubviews(lineView)
        
        lineView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(Screen.height(1))
        }
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .white
        navigationItem.standardAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
    }
    
    /// 네비게이션 바 BackButton 구성
    final func setupNavigationBarBackButton() {
        let backButton = UIBarButtonItem(
            image: .iconBack,
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        ).then {
            $0.tintColor = .black
        }
        navigationItem.leftBarButtonItem = backButton
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}

private extension BaseViewController {
    @objc
    func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
