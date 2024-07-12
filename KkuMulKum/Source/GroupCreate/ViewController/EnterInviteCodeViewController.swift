//
//  EnterInviteCodeViewController.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/12/24.
//

import UIKit

class EnterInviteCodeViewController: BaseViewController {
    private let inviteCodeViewModel: InviteCodeViewModel = InviteCodeViewModel()
    
    private let inviteCodeView: InviteCodeView = InviteCodeView()
    
    override func loadView() {
        view = inviteCodeView
    }
    
    override func viewDidLoad() {
        setupBinding()
        setupTapGesture()
    }
    
    override func setupView() {
        setupNavigationBarTitle(with: "내 모임 추가하기")
        setupNavigationBarBackButton()
    }

    private func setupBinding() {
        inviteCodeViewModel.inviteCodeState.bind(with: self) { owner, state in
            switch state {
            case .empty:
                self.inviteCodeView.inviteCodeTextField.layer.borderColor = UIColor.gray3.cgColor
                self.inviteCodeView.errorLabel.isHidden = true
                self.inviteCodeView.checkImageView.isHidden = true
            case.selected:
                self.inviteCodeView.inviteCodeTextField.layer.borderColor = UIColor.maincolor.cgColor
                self.inviteCodeView.errorLabel.isHidden = true
                self.inviteCodeView.checkImageView.isHidden = true
            case .invalid:
                self.inviteCodeView.inviteCodeTextField.layer.borderColor = UIColor.mainred.cgColor
                self.inviteCodeView.errorLabel.isHidden = false
                self.inviteCodeView.checkImageView.isHidden = true
            case .valid:
                self.inviteCodeView.inviteCodeTextField.layer.borderColor = UIColor.maincolor.cgColor
                self.inviteCodeView.errorLabel.isHidden = true
                self.inviteCodeView.checkImageView.isHidden = false
            }
        }
    }
    
    override func setupAction() {
        inviteCodeView.inviteCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        inviteCodeView.presentButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func setupDelegate() {
        inviteCodeView.inviteCodeTextField.delegate = self
        inviteCodeView.inviteCodeTextField.returnKeyType = .done
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func nextButtonTapped() {
        // TODO: 서버 연결할 때 데이터 바인딩해서 화면 전환 시키기
        let promiseViewController = PromiseViewController()
        
        promiseViewController.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(promiseViewController, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        inviteCodeViewModel.validateCode(textField.text ?? "")
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        inviteCodeView.inviteCodeTextField.layer.borderColor = UIColor.gray3.cgColor
    }
}

extension EnterInviteCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        inviteCodeView.inviteCodeTextField.layer.borderColor = UIColor.gray3.cgColor
        
        return true
    }
}

