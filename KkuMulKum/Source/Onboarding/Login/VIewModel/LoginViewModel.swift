//
//  LoginVM.swift
//  KkuMulKum
//
//  Created by 이지훈 on 7/9/24.
//

import UIKit
import AuthenticationServices

import KakaoSDKUser
import KakaoSDKAuth
import Moya

enum LoginState {
    case notLogin
    case login(userInfo: String)
    case needOnboarding
}

class LoginViewModel: NSObject {
    var loginState: ObservablePattern<LoginState> = ObservablePattern(.notLogin)
    var error: ObservablePattern<String> = ObservablePattern("")
    
    private let provider: MoyaProvider<LoginTargetType>
    
    init(
        provider: MoyaProvider<LoginTargetType> = MoyaProvider<LoginTargetType>(
            plugins: [NetworkLoggerPlugin(
                configuration: .init(
                    logOptions: .verbose
                )
            )]
        )
    ) {
        self.provider = provider
        super.init()
    }
    
    func performAppleLogin(presentationAnchor: ASPresentationAnchor) {
        print("Performing Apple Login")
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func performKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            print("Kakao Talk is available")
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            print("Kakao Talk is not available")
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
            }
        }
    }
    
    private func handleKakaoLoginResult(oauthToken: OAuthToken?, error: Error?) {
        if let error = error {
            print("Kakao Login Error: \(error.localizedDescription)")
            self.error.value = error.localizedDescription
            return
        }
        
        if let token = oauthToken?.accessToken {
            print("Kakao Login Successful, access token: \(token)")
            loginToServer(with: .kakaoLogin(accessToken: token, fcmToken: "dummy_fcm_token"))
        } else {
            print("Kakao Login Error: No access token")
            self.error.value = "No access token received"
        }
    }
    
    private func loginToServer(with loginTarget: LoginTargetType) {
        provider.request(loginTarget) { [weak self] result in
            switch result {
            case .success(let response):
                print("Received response from server: \(response)")
                do {
                    let loginResponse = try response.map(ResponseBodyDTO<SocialLoginResponseModel>.self)
                    print("Successfully mapped response: \(loginResponse)")
                    self?.handleLoginResponse(loginResponse)
                } catch {
                    print("Failed to decode response: \(error)")
                    self?.error.value = "Failed to decode response: \(error.localizedDescription)"
                }
                
            case .failure(let error):
                print("Network error: \(error)")
                self?.error.value = "Network error: \(error.localizedDescription)"
            }
        }
    }
    
    private func handleLoginResponse(_ response: ResponseBodyDTO<SocialLoginResponseModel>) {
            print("Handling login response")
            if response.success {
                if let data = response.data {
                    if let name = data.name {
                        print("Login successful, user name: \(name)")
                        loginState.value = .login(userInfo: name)
                    } else {
                        print("Login successful, but no name provided. Needs onboarding.")
                        loginState.value = .needOnboarding
                    }
                    
                    let tokens = data.jwtTokenDTO
                    print("Received tokens - Access: \(tokens.accessToken), Refresh: \(tokens.refreshToken)")
                    // TODO: 토큰 저장 로직 구현
                } else {
                    print("Warning: No data received in response")
                    error.value = "No data received"
                }
            } else {
                if let error = response.error {
                    print("Login failed: \(error.message)")
                    self.error.value = error.message
                } else {
                    print("Login failed: Unknown error")
                    self.error.value = "Unknown error occurred"
                }
            }
        }
    
}

extension LoginViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        print("Apple authorization completed")
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = appleIDCredential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else {
            print("Failed to get Apple ID Credential or identity token")
            return
        }
        
        print("Apple Login Successful, identity token: \(tokenString)")
        loginToServer(with: .appleLogin(identityToken: tokenString, fcmToken: "dummy_fcm_token"))
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("Apple authorization error: \(error.localizedDescription)")
        self.error.value = error.localizedDescription
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        print("Providing presentation anchor for Apple Login")
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window!
    }
}
