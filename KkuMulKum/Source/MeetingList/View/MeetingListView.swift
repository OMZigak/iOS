//
//  MeetingListView.swift
//  KkuMulKum
//
//  Created by 예삐 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class MeetingListView: BaseView {
    
    
    // MARK: - Property
    
    private let header = UIView()
    
    let infoLabel = UILabel()
    
    let addButton = UIButton().then {
        $0.backgroundColor = .green2
        $0.layer.cornerRadius = 8
    }
    
    private let addInfoView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let addInfoLabel = UILabel().then {
        $0.setText("모임 추가하기", style: .body05, color: .green3)
    }
    
    private let addIconImageView = UIImageView().then {
        $0.image = .icGroupPlus
    }
    
    lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.tableHeaderView = header
    }
    
    let emptyCharacter = UIImageView().then {
        $0.image = .imgEmpty
        $0.isHidden = true
    }
    
    let emptyLabel = UILabel().then {
        $0.setText("아직 모임이 없네요!\n모임을 추가해 보세요.", style: .body05, color: .gray4)
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    
    // MARK: - UI Setting
    
    override func setupView() {
        self.backgroundColor = .gray0
        addSubviews(tableView, emptyCharacter, emptyLabel)
        header.addSubviews(infoLabel, addButton, addInfoView)
        addInfoView.addArrangedSubviews(addIconImageView, addInfoLabel)
    }
    
    override func setupAutoLayout() {
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Screen.height(48))
        }
        
        emptyCharacter.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom).offset(94)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Screen.height(126))
            $0.width.equalTo(Screen.width(73))
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyCharacter.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        addInfoView.snp.makeConstraints {
            $0.centerY.equalTo(addButton.snp.centerY)
            $0.centerX.equalTo(addButton.snp.centerX)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width-40)
            $0.height.equalTo(Screen.height(174))
        }
    }
}
