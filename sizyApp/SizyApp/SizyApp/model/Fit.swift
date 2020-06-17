//
//  Fit.swift
//  SizyApp
//
//  Created by 임명준 on 2020/06/17.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation


enum Fit: String{
    case fitWell = "잘 맞는"
    case fitEnough = "넉넉한"
    case looseFit = "루즈핏"
    case shortFit = "짧은"
    case longFit = "긴"
    
    func getString()->String{
        switch self {
        case .fitEnough:
            return self.rawValue
        case .fitWell:
            return self.rawValue
        case .longFit:
            return self.rawValue
        case .looseFit:
            return self.rawValue
        case .shortFit:
            return self.rawValue
        default:
            debugPrint("it is default")
        }
    }
}

struct FitData{
    static let shared = FitData()
    private init(){}
    let fits: [Fit] = [.fitWell,.fitEnough,.looseFit,.shortFit,.shortFit,.longFit]

}
