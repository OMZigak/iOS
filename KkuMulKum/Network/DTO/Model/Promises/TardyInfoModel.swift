//
//  PromiseLateInfoResponseModel.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/8/24.
//


// MARK: 약속 지각 상세 조회

import Foundation

struct TardyInfoModel: ResponseModelType {
    let penalty: String
    let isPastDue: Bool
    let lateComers: [Comer]
}

struct Comer: Codable {
    let participantId: Int
    let name, profileImg: String
}