//
//  CommonFunctions.swift
//  femcy
//
//  Created by GOQii-Ajeet on 30/03/2020.
//  Copyright © 2020 GOQii-Ajeet. All rights reserved.
//

import Foundation
import UIKit

let imgPathConstant = "https://image.tmdb.org/t/p/w200"
let imgBackPathConstant = "https://image.tmdb.org/t/p/original"
let API_Key = "69f4bcc96d41f3454e1e9a0775c77b7f"

/// Presents alert based upon provided param details
func showAlert(title: String?, msg: String, controller: UIViewController) {

    let alert = UIAlertController(title:title ?? "", message:msg, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (ACTION : UIAlertAction!)in
        
    }))
    controller.present(alert, animated: true, completion: nil)
}


extension UIView {
    ///Creates the shadow layer on view
    func addShadowLayer(view : UIView) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 1.0
        view.layer.cornerRadius = 5.0
    }
    
    ///Creates the gradient overlay on top of view
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
     let gradient = CAGradientLayer()
     gradient.frame = frame
     gradient.colors = colors.map{$0.cgColor}
     self.layer.addSublayer(gradient)
    }

}

