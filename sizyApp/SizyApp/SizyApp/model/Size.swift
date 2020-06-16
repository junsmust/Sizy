//
//  Size.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/23.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation
import UIKit

enum MainCategory: String {
   
    static let menus: [MainCategory] = [.top,.pants,.onePiece,.skirt,.shoe]
    
    case top = "상의"
    case pants = "하의"
    case onePiece = "원피스"
    case skirt = "치마"
    case shoe = "신발"
    
    static func getIcon(category: MainCategory)->UIImage?{
        switch category {
        case .top:
            return #imageLiteral(resourceName: "top")
        case .onePiece:
            return #imageLiteral(resourceName: "onepiece")
        case .pants:
            return #imageLiteral(resourceName: "pants")
        case .shoe:
            return #imageLiteral(resourceName: "shoe")
        case .skirt:
            return #imageLiteral(resourceName: "skirt")
        @unknown default:
            debugPrint("default")
        }
    }
    static func getSubCategory(subCategory: MainCategory)->[Any]{
        switch subCategory {
        case .onePiece:
            return OnePiceSubCategory.subCategories
        case .pants:
            return PantSubCategory.subCategories
        case .shoe:
            return ShoeSubCategory.subCategories
        case .skirt:
            return SkirtSubCategory.subCategories
        case .top:
            return TopSubCategory.subCategories
        @unknown default:
            debugPrint("")
        }
    }
    enum TopSubCategory: String {
        static let subCategories: [TopSubCategory] = [.shirt,.shortSleeve,.longShirt,.shortSleeve,.doMySelf]
        case shortSleeve = "반팔"
        case longShirt = "긴팔"
        case sleeveless = "민소매"
        case shirt = "셔츠"
        case doMySelf = "+ 직업입력"
    }
    enum OuterSubCategory: String{
        static let subCategories: [OuterSubCategory] = [.coat,.jacket,.doMySelf]

        case coat = "코트"
        case padding = "패딩"
        case jacket = "자켓"
        case doMySelf = "+ 직업입력"
    }
    
    enum OnePiceSubCategory: String{
        
        static let subCategories: [OnePiceSubCategory] = [.mini,.midim,.long,.doMySelf]

        case mini = "미니 원피스"
        case midim = "미디 원피스"
        case long = "롱 원피스"
        case doMySelf = "+ 직업입력"

    }
    enum SkirtSubCategory: String{
           
        static let subCategories: [SkirtSubCategory] = [.mini,.midim,.long,.doMySelf]

           case mini = "미니 스커트"
           case midim = "미디 스커트"
           case long = "롱 스커트"
           case doMySelf = "+ 직업입력"
       }

    enum PantSubCategory: String{
        
        static let subCategories: [PantSubCategory] = [.longPants,.shortPant,.leggings,.doMySelf]

        case longPants = "긴 바지"
        case shortPant = "반 바지"
        case leggings = "레깅스"
        case doMySelf = "+ 직업입력"
    }
    
    enum ShoeSubCategory: String{
        
        static let subCategories: [ShoeSubCategory] = [.shoes,.highHeel,.doMySelf]

        case shoes = "운동화"
        case highHeel = "구두"
        case doMySelf = "+ 직업입력"
    }
    
}


