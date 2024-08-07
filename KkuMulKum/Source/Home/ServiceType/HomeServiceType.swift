//
//  HomeServiceType.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/18/24.
//

import Foundation

import Moya

protocol HomeServiceType {
    func fetchLoginUser() async throws -> ResponseBodyDTO<LoginUserModel>?
    func fetchNearestPromise() async throws -> ResponseBodyDTO<NearestPromiseModel>?
    func fetchUpcomingPromise() async throws -> ResponseBodyDTO<UpcomingPromiseListModel>?
    func fetchMyReadyStatus(with promiseID: Int) async throws -> ResponseBodyDTO<MyReadyStatusModel>?
    
    func updatePreparationStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>?
    func updateDepartureStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>?
    func updateArrivalStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>?
}

extension HomeService: HomeServiceType {
    func fetchMyReadyStatus(with promiseID: Int) async throws -> ResponseBodyDTO<MyReadyStatusModel>? {
        return try await request(with: .fetchMyReadyStatus(promiseID: promiseID))
    }
    
    func updatePreparationStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>? {
        return try await request(
            with: .updatePreparationStatus(promiseID: promiseID)
        )
    }
    
    func updateDepartureStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>? {
        return try await request(
            with: .updateDepartureStatus(promiseID: promiseID)
        )
    }
    
    func updateArrivalStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>? {
        return try await request(
            with: .updateArrivalStatus(promiseID: promiseID)
        )
    }
    
    func fetchLoginUser() async throws -> ResponseBodyDTO<LoginUserModel>? {
        return try await request(with: .fetchLoginUser)
    }
    
    func fetchNearestPromise() async throws -> ResponseBodyDTO<NearestPromiseModel>? {
        return try await request(with: .fetchNearestPromise)
    }
    
    func fetchUpcomingPromise() async throws -> ResponseBodyDTO<UpcomingPromiseListModel>? {
        return try await request(with: .fetchUpcomingPromise)
    }
}

final class MockHomeService: HomeServiceType {
    func fetchMyReadyStatus(with promiseID: Int) async throws -> ResponseBodyDTO<MyReadyStatusModel>? {
        return nil
    }
    
    func updatePreparationStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>? {
        return nil
    }
    
    func updateDepartureStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>? {
        return nil
    }
    
    func updateArrivalStatus(with promiseID: Int) async throws -> ResponseBodyDTO<EmptyModel>? {
        return nil
    }
    
    func fetchLoginUser() async throws -> ResponseBodyDTO<LoginUserModel>? {
        let mockData = ResponseBodyDTO<LoginUserModel>(
            success: true,
            data: LoginUserModel(
                userID: 1,
                name: "꾸물리안",
                level: 4,
                promiseCount: 8,
                tardyCount: 2,
                tardySum: 72,
                profileImageURL: ""
            ),
            error: nil
        )
        return mockData
    }
    
    func fetchNearestPromise() async throws -> ResponseBodyDTO<NearestPromiseModel>? {
        let mockData = ResponseBodyDTO<NearestPromiseModel>(
            success: true,
            data: NearestPromiseModel(
                promiseID: 1,
                dDay: 0,
                name: "꾸물이들 대환장 파티",
                meetingName: "꾸물이들",
                dressUpLevel: "냐미",
                date: "2024.07.16",
                time: "PM 8:00",
                placeName: "DMC역"
            ),
            error: nil
        )
        return mockData
    }
    
    func fetchUpcomingPromise() async throws -> ResponseBodyDTO<UpcomingPromiseListModel>? {
        let mockData = ResponseBodyDTO<UpcomingPromiseListModel>(
            success: true,
            data: UpcomingPromiseListModel(
                promises: [
                    UpcomingPromise(
                        promiseID: 1,
                        dDay: 1,
                        name: "누가 코코볼 다 먹었어?",
                        meetingName: "우마우스",
                        dressUpLevel: "",
                        date: "2024.07.17",
                        time: "PM 2:00",
                        placeName: "가자하우스"
                    ),
                    UpcomingPromise(
                        promiseID: 2,
                        dDay: 1,
                        name: "누가 코코볼 다 먹었어?",
                        meetingName: "우마우스",
                        dressUpLevel: "",
                        date: "2024.07.17",
                        time: "PM 2:00",
                        placeName: "가자하우스"
                    ),
                    UpcomingPromise(
                        promiseID: 3,
                        dDay: 1,
                        name: "누가 코코볼 다 먹었어?",
                        meetingName: "우마우스",
                        dressUpLevel: "",
                        date: "2024.07.17",
                        time: "PM 2:00",
                        placeName: "가자하우스"
                    ),
                    UpcomingPromise(
                        promiseID: 4,
                        dDay: 1,
                        name: "누가 코코볼 다 먹었어?",
                        meetingName: "우마우스",
                        dressUpLevel: "",
                        date: "2024.07.17",
                        time: "PM 2:00",
                        placeName: "가자하우스"
                    )
                ]
            ),
            error: nil
        )
        return mockData
    }
}
