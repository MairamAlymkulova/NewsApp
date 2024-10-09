//
//  UIView+Extention.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

extension UIView{
    func addSubviews (views: [UIView]){
        for view in views {
            self.addSubview(view)

        }
    }
}
