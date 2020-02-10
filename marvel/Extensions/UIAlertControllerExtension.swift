//
//  UIAlertControllerExtension.swift
//  library
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 04/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

extension UIAlertController {
    func errorMsg(_ text: String, handler:((UIAlertAction)->Void)?) -> UIAlertController {
        let msg = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        msg.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        return msg
    }
}
