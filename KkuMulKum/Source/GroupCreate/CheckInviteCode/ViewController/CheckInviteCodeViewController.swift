//
//  CheckInviteCodeViewController.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/11/24.
//

import UIKit

class CheckInviteCodeViewController: BaseViewController {
    private let checkInviteCodeView: CheckInviteCodeView = CheckInviteCodeView()
    
    override func loadView() {
        view = checkInviteCodeView
    }
    
    override func setupView() {
        view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        
        setupNavigationBarTitle(with: "내 모임 추가하기")
        setupNavigationBarBackButton()
    }
    
    override func setupAction() {
        checkInviteCodeView.enterInviteCodeView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(inviteCodeViewDidTap)
        ))
        checkInviteCodeView.createGroupView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(createGroupViewDidTap)
        ))
    }
    
    @objc private func inviteCodeViewDidTap() {
        let inviteCodeViewController = InviteCodeViewController()
        
        inviteCodeViewController.modalTransitionStyle = .crossDissolve
        inviteCodeViewController.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(inviteCodeViewController, animated: true)
    }
    
    @objc private func createGroupViewDidTap() {
        let createGroupViewController = CreateGroupViewController()
        
        createGroupViewController.modalTransitionStyle = .crossDissolve
        createGroupViewController.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(createGroupViewController, animated: true)
    }
}
