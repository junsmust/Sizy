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

/// 카카오 Open API의 카카오톡 API 호출을 담당하는 클래스입니다.
///
/// 프로필 조회, 친구 목록, 메시지 보내기 등이 기능을 제공합니다.
public class TalkApi {
    
    // MARK: Fields
    
    /// 간편하게 API를 호출할 수 있도록 제공되는 공용 싱글톤 객체입니다.
    public static let shared = TalkApi()
    
    // MARK: Enumerations
    
    /// 목록 조회 API에 사용되는 정렬 방식 열거형
    public enum Order {
        /// 오름차순
        case Asc
        /// 내림차순
        case Desc
        
        public var parameterValue: String {
            switch self {
            case .Asc:
                return "asc"
            case .Desc:
                return "desc"
            }
        }
    }
}
