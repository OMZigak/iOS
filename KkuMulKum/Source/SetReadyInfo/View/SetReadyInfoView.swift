//
//  SetReadyInfoView.swift
//  KkuMulKum
//
//  Created by 예삐 on 7/14/24.
//

import UIKit

import SnapKit
import Then

final class SetReadyInfoView: BaseView {
    
    
    // MARK: - Property

    private let infoLabel = UILabel().then {
        $0.setText("준비 정보를 입력해보세요!", style: .head01, color: .gray8)
    }
    
    private let readyTimeLabel = UILabel().then {
        $0.setText("준비 시간", style: .body03, color: .gray8)
    }
    
    private let readyTimeView = UIStackView(axis: .horizontal).then {
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    let readyHourTextField = CustomTextField(placeHolder: "00")
    
    private let readyHourLabel = UILabel().then {
        $0.setText("시간", style: .body03, color: .gray8)
    }
    
    let readyMinuteTextField = CustomTextField(placeHolder: "00")
    
    private let readyMinuteLabel = UILabel().then {
        $0.setText("분", style: .body03, color: .gray8)
    }
    
    private let moveTimeLabel = UILabel().then {
        $0.setText("이동 시간", style: .body03, color: .gray8)
    }
    
    private let moveTimeView = UIStackView(axis: .horizontal).then {
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    let moveHourTextField = CustomTextField(placeHolder: "00")
    
    private let moveHourLabel = UILabel().then {
        $0.setText("시간", style: .body03, color: .gray8)
    }
    
    let moveMinuteTextField = CustomTextField(placeHolder: "00")
    
    private let moveMinuteLabel = UILabel().then {
        $0.setText("분", style: .body03, color: .gray8)
    }
    
    let doneButton = CustomButton(title: "완료", isEnabled: false)
    
    
    // MARK: - UI Setting
    
    override func setupView() {
        addSubviews(infoLabel, readyTimeLabel, readyTimeView, moveTimeView, moveTimeLabel, doneButton)
        readyTimeView.addArrangedSubviews(
            readyHourTextField,
            readyHourLabel,
            readyMinuteTextField,
            readyMinuteLabel
        )
        moveTimeView.addArrangedSubviews(
            moveHourTextField,
            moveHourLabel,
            moveMinuteTextField,
            moveMinuteLabel
        )
    }
    
    override func setupAutoLayout() {
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-64)
            $0.height.equalTo(Screen.height(52))
        }
        
        readyTimeLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        readyTimeView.snp.makeConstraints {
            $0.top.equalTo(readyTimeLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        readyHourTextField.snp.makeConstraints {
            $0.width.equalTo(56)
            $0.height.equalTo(44)
        }
        
        readyMinuteTextField.snp.makeConstraints {
            $0.width.equalTo(56)
            $0.height.equalTo(44)
        }
        
        moveTimeLabel.snp.makeConstraints {
            $0.top.equalTo(readyTimeView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        moveTimeView.snp.makeConstraints {
            $0.top.equalTo(moveTimeLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        moveHourTextField.snp.makeConstraints {
            $0.width.equalTo(56)
            $0.height.equalTo(44)
        }
        
        moveMinuteTextField.snp.makeConstraints {
            $0.width.equalTo(56)
            $0.height.equalTo(44)
        }
    }
}
