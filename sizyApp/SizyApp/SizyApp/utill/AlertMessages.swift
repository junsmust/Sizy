//
//  AlertMessages.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/08.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation
import UIKit

typealias YesCallBack = ()->Void
typealias NoCallBack = ()->Void

class AlertMessage{
    public static let alertMessage: AlertMessage = AlertMessage()
    func defaulAlertDialog(msgTitle title:String?,msgMessage message:String,ok okTitle:String,no noTitle:String?, yesAction yAction:@escaping YesCallBack,noAction nAction: NoCallBack?,toView view:UIViewController){
        let defaultAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction: UIAlertAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            debugPrint("yesAction")
            yAction()
        }
        defaultAlert.addAction(yesAction)
        if nAction != nil{
           let noAction: UIAlertAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                debugPrint("noAction")
            }
             defaultAlert.addAction(noAction)
        }
        view.present(defaultAlert, animated: true, completion: nil)
    }
}
