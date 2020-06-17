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
import Alamofire
import RxAlamofire

public class AuthSelfRequestAdapter : RequestAdapter {
    private let kaHeader: String
    
    public init(kaHeader: String = Constants.kaHeader) {
        self.kaHeader = kaHeader
    }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(Constants.kaHeader, forHTTPHeaderField: "KA")
        return urlRequest
    }
}

public class TheOthersRequestAdapter : RequestAdapter {
    private let kaHeader: String
    
    public init(kaHeader: String = Constants.kaHeader) {
        self.kaHeader = kaHeader
    }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(Constants.kaHeader, forHTTPHeaderField: "KA")
        return urlRequest
    }
}