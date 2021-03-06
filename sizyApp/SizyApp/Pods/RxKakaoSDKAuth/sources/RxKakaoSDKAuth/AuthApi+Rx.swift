//  Copyright 2019 Kakao Corp.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import RxKakaoSDKCommon

extension AuthApi: ReactiveCompatible {}

extension Reactive where Base: AuthApi {
   
    // MARK: Methods
    
    /// :nodoc: 인증코드 요청입니다. TODO: 제거?
    public func authorizeRequest(parameters:[String:Any]) -> URLRequest? {
        guard let finalUrl = SdkUtils.makeUrlWithParameters(Urls.compose(.Kauth, path:Paths.authAuthorize), parameters:parameters) else { return nil }
        return URLRequest(url: finalUrl)
    }
    
    /// :nodoc: 동적 동의 요청시 인증값으로 사용되는 임시토큰 발급 요청입니다. SDK 내부 전용입니다.
    public func agt() -> Single<String?> {
        return Api.shared.rx.responseData(.post, Urls.compose(.Kauth, path:Paths.authAgt),
                                parameters: ["client_id":try! KakaoSDKCommon.shared.appKey(),
                                             "access_token":auth.tokenManager.getToken()?.accessToken].filterNil(),
                                sessionManagerType:.AuthSelf)
            .compose(Api.shared.rx.checkKAuthErrorComposeTransformer())
            .map({ (response, data) -> String? in
                if let json = (try? JSONSerialization.jsonObject(with:data, options:[])) as? [String: Any] {
                    return json["agt"] as? String
                }
                else {
                    return nil
                }
            })
            .do (
                onNext: { ( decoded ) in
                    RxSdkLog.i("decoded model:\n \(String(describing: decoded))\n\n" )
                }
            )
            .asSingle()
    }
    
    /// 사용자 인증코드를 이용하여 신규 토큰 발급을 요청합니다.
    public func token(grantType: String = "authorization_code",
                      clientId: String = try! KakaoSDKCommon.shared.appKey(),
                      redirectUri: String = try! KakaoSDKCommon.shared.redirectUri(),
                      code: String) -> Single<OAuthToken> {
        return Api.shared.rx.responseData(.post,
                                Urls.compose(.Kauth, path:Paths.authToken),
                                parameters: ["grant_type":grantType,
                                             "client_id":clientId,
                                             "redirect_uri":redirectUri,
                                             "code":code,
                                             "ios_bundle_id":Bundle.main.bundleIdentifier].filterNil(),
                                sessionManagerType:.AuthSelf)
            .compose(Api.shared.rx.checkKAuthErrorComposeTransformer())
            .map({ (response, data) -> OAuthToken in
                return try SdkJSONDecoder.custom.decode(OAuthToken.self, from: data)
            })
            .do (
                onNext: { ( decoded ) in
                    RxSdkLog.i("decoded model:\n \(String(describing: decoded))\n\n" )
                }
            )
            .asSingle()
            .do(onSuccess: { (oauthToken) in
                auth.tokenManager.setToken(oauthToken)
            })
    }
    
    /// 기존 토큰을 갱신합니다.
    public func refreshAccessToken(clientId: String = try! KakaoSDKCommon.shared.appKey(),
                                   refreshToken: String? = nil) -> Single<OAuthToken> {
        return Api.shared.rx.responseData(.post,
                                Urls.compose(.Kauth, path:Paths.authToken),
                                parameters: ["grant_type":"refresh_token",
                                             "client_id":clientId,
                                             "refresh_token":refreshToken ?? auth.tokenManager.getToken()?.refreshToken,
                                             "ios_bundle_id":Bundle.main.bundleIdentifier].filterNil(),
                                sessionManagerType:.AuthSelf)
            .compose(Api.shared.rx.checkKAuthErrorComposeTransformer())
            .map({ (response, data) -> OAuthToken in
                let newToken = try SdkJSONDecoder.custom.decode(Token.self, from: data)
                
                //oauthtoken 객체가 없으면 에러가 나야함.
                guard let oldOAuthToken = auth.tokenManager.getToken() else { throw SdkError(reason: .TokenNotFound) }
                
                var newRefreshToken: String {
                    if let refreshToken = newToken.refreshToken {
                        return refreshToken
                    }
                    else {
                        return oldOAuthToken.refreshToken
                    }
                }
                
                var newRefreshTokenExpiresIn : TimeInterval {
                    if let refreshTokenExpiresIn = newToken.refreshTokenExpiresIn {
                        return refreshTokenExpiresIn
                    }
                    else {
                        return oldOAuthToken.refreshTokenExpiresIn
                    }
                }
                
                let oauthToken = OAuthToken(accessToken: newToken.accessToken,
                                            expiresIn: newToken.expiresIn,
                                            tokenType: newToken.tokenType,
                                            refreshToken: newRefreshToken,
                                            refreshTokenExpiresIn: newRefreshTokenExpiresIn,
                                            scope: newToken.scope,
                                            scopes: newToken.scopes)
                return oauthToken
            })
            .do (
                onNext: { ( decoded ) in
                    RxSdkLog.i("decoded model:\n \(String(describing: decoded))\n\n" )
                }
            )
            .asSingle()
            .do(onSuccess: { (oauthToken) in
                auth.tokenManager.setToken(oauthToken)
            })
    }
}
