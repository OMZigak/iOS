//
//  PromiseInfoViewController.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/9/24.
//

import UIKit

class PromiseInfoViewController: BaseViewController {
    private let promiseInfoView: PromiseInfoView = PromiseInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        view.addSubview(promiseInfoView)
        
        promiseInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupDelegate() {
        promiseInfoView.participantCollectionView.delegate = self
        promiseInfoView.participantCollectionView.dataSource = self
    }
}


extension PromiseInfoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticipantCollectionViewCell.reuseIdentifier, for: indexPath) as? ParticipantCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
