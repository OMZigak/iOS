//
//  PromiseLateInfoResponseModel.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/8/24.
//


// MARK: 약속 지각 상세 조회

import Foundation

struct PromiseLateInfoResponseModel: Codable {
    let penalty, name, profileImageURL: String
    let isPastDue: Bool
    let lateComers: [Comer]
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case penalty
        case name
        case profileImageURL = "profileImg"
        case isPastDue
        case lateComers
        case id
    }
}

struct Comer: Codable {
    let id: Int
    let name, profileImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImageURL = "profileImg"
    }
}