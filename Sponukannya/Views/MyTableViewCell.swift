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
                cellView.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 5),
                cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
                cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
                 ])
            // noteLabel
            noteLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                noteLabel.trailingAnchor.constraint(equalTo:cellView.trailingAnchor,constant: -10),
                noteLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
                noteLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
                noteLabel.leadingAnchor.constraint(equalTo:numberLabel.trailingAnchor, constant: 10)
                 ])
            // numberLabel
               numberLabel.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                 numberLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
                 numberLabel.trailingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 60.0),
                 numberLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor),
                 numberLabel.bottomAnchor.constraint (equalTo: cellView.bottomAnchor)
                 ])
        }

    
    //MARK: - OTHERS
    override func prepareForReuse() {
        noteLabel.text = nil
       numberLabel.text = nil
    }
}


    
   

