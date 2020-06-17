//
//  AlertService.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/12.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation
import UIKit

struct AlertService {
    
    func createUserAlert(completion: @escaping (String) -> Void) -> UIAlertController{
        let alert = UIAlertController(title: "Create User", message: nil, preferredStyle: .alert)
        alert.addTextField {
            $0.placeholder = "Enter user's name"
        }
        let action = UIAlertAction(title: "Save", style: .default){ _ in
            let userName = alert.textFields?.first?.text ?? ""
            completion(userName)
        }
        alert.addAction(action)
        
        return alert
    }
}
