//
//  MyTableViewCell.swift
//  Sponukannya
//
//  Created by Ben on 10.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import Foundation
import UIKit
import MGSwipeTableCell

class MyTableViewCell: MGSwipeTableCell{

var backgroundCellView = UIImageView()
var cellView = UIView()
var noteLabel = UILabel()
var numberLabel = UILabel()
    
    //MARK: - Implementation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //    MARK: setupCellView
    private func setupCellView () {
            contentView.isOpaque = false
            contentView.backgroundColor = UIColor.clear

            // cellView
            cellView.backgroundColor = UIColor (named: "cellBackgroundColor")
            cellView.layer.cornerRadius = 10
        
            contentView.addSubview(cellView)
            // noteLabel
            noteLabel.textAlignment = .left
        //Custom fonts Dynamic stile
        let fontA = UIFont(name: NSLocalizedString("IndieFlower", comment: "IndieFlower"), size: 28)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        noteLabel.font = fontMetrics.scaledFont(for: fontA!)

            noteLabel.adjustsFontForContentSizeCategory = true
            noteLabel.textColor = UIColor (named: "textColor")
            noteLabel.backgroundColor = UIColor.clear
            noteLabel.numberOfLines = 0
            //  shob ne bulo krapochok v kintsi ...
        noteLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
            cellView.addSubview(noteLabel)
            // numberLabel
            numberLabel.textAlignment = .center
                //Custom fonts Dynamic stile
                let fontB = UIFont(name: NSLocalizedString("IndieFlower", comment: "IndieFlower"), size: 28)
                numberLabel.font = fontMetrics.scaledFont(for: fontB!)
 
            numberLabel.adjustsFontForContentSizeCategory = true
            numberLabel.textColor = UIColor (named: "textColor")
            numberLabel.backgroundColor = UIColor.clear
        numberLabel.numberOfLines = 0
            cellView.addSubview(numberLabel)
           }
    
//    MARK: SetupLayout
        private func setupLayout() {
            // cellView
            cellView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                cellView.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10),
                cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
                cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
                 ])
            // noteLabel
            noteLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                noteLabel.trailingAnchor.constraint(equalTo:cellView.trailingAnchor),
                noteLabel.topAnchor.constraint(equalTo: cellView.topAnchor),
                noteLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
                noteLabel.leadingAnchor.constraint(equalTo:numberLabel.trailingAnchor)
                 ])
            // numberLabel
               numberLabel.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                 numberLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
                 numberLabel.trailingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 60.0),
                 numberLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor),
                 numberLabel.bottomAnchor.constraint (equalTo: cellView.bottomAnchor)
                 ])
    
            //Castom Font Instance
//            guard UIFont(name: "IndieFlower", size: UIFont.labelFontSize) != nil else {
//               fatalError("""
//                   Failed to load the "IndieFlower" font.
//                   Make sure the font file is included in the project and the font name is spelled correctly.
//                   """)
//                }
        }
//    MARK: Selection
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
//    //        //  Labels Taxt Selected color
//            noteLabel.textColor = selected ? UIColor.red : UIColor.black
//            numberLabel.textColor = selected ? UIColor.red : UIColor.black
//    //        //  Labels Background Selected color
            cellView.backgroundColor = selected ? UIColor(named: "selectedCellColor"): UIColor (named: "cellBackgroundColor")
//    //        //  Image View Selected color
//    //        backgroundCellView.backgroundColor = selected ? UIColor.green : UIColor.clear
//
        }

    
    //MARK: - OTHERS
    override func prepareForReuse() {
        noteLabel.text = nil
       numberLabel.text = nil
    }
}


//MARK: Fonts
    
    extension UIFont {
        class func cellLB( size:CGFloat ) -> UIFont{
            return  UIFont(name: Fonts.cellLabelFont, size: size)!
        }
    }

    enum Fonts {
             // Font
             static let cellLabelFont = NSLocalizedString("IndieFlower", comment: "IndieFlower")
             }
    
   

