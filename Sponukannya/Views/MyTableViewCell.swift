//
//  MyTableViewCell.swift
//  Sponukannya
//
//  Created by Ben on 10.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell{

var backgroundCellView = UIImageView()
var cellView = UIView()
var noteLabel = MyLabel()
var numberLabel = UILabel()
    
//    MARK: My Label
    // Custom class MyLabel. Making text marging (width of numberLabel) for noteLabel's text.
    class MyLabel: UILabel{
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 43, bottom: 0, right: 0)))
            }
            }
    
}
