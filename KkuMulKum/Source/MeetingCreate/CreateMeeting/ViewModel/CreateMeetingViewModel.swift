//
//  CreateMeetingViewModel.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/12/24.
//

import Foundation

enum MeetingNameState {
    case empty
    case valid
    case invalid
}

class CreateMeetingViewModel {
    
    
    // MARK: Property
    
    var createMeetingResponse = ObservablePattern<MakeMeetingsResponseModel?>(nil)
    let createMeetingService: CreateMeetingServiceType
    let isNextButtonEnabled = ObservablePattern<Bool>(false)
    let meetingName = ObservablePattern<String>("")
    let inviteCode = ObservablePattern<String>("")
    let characterCount = ObservablePattern<String>("0/5")
    let inviteCodeState = ObservablePattern<MeetingNameState>(.empty)
    private (set) var meetingID: Int = 0
    
    
    // MARK: Initialize

    init(createMeetingService: CreateMeetingServiceType) {
        self.createMeetingService = createMeetingService
    }
}


// MARK: - Extension

extension CreateMeetingViewModel {
    func validateName(_ name: String) {
        meetingName.value = name
        characterCount.value = "\(name.count)/10"
        
        if name.isEmpty {
            inviteCodeState.value = .empty
            isNextButtonEnabled.value = false
        } else if name.count > 10 {
            inviteCodeState.value = .invalid
            isNextButtonEnabled.value = false
        } else {
            inviteCodeState.value = .valid
            isNextButtonEnabled.value = true
        }
    }
    
    /// 모임 생성 네트워크 통신
    func createMeeting(name: String) {
        Task {
            do {
                let request = MakeMeetingsRequestModel(name: name)
                
                createMeetingResponse.value = try await createMeetingService.createMeeting(request: request)?.data
                
                guard let code = self.createMeetingResponse.value?.invitationCode else {
                    return
                }
                guard let meetingID = self.createMeetingResponse.value?.meetingID else {
                    return
                }
                
                inviteCode.value = code
                self.meetingID = meetingID
            }
            catch {
                print(">>> \(error.localizedDescription) : \(#function)")
            }
        }
    }
}
