//
//  ListTableViewCell.swift
//  Sponukannya
//
//  Created by Ben on 26.04.2020.
//  Copyright © 2020 Ben. All rights reserved.
//


import Foundation
import UIKit
import MGSwipeTableCell

class ListTableViewCell: UITableViewCell{

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
        let fontA = UIFont(name: NSLocalizedString("Lato-Light", comment: "Lato-Light"), size: 28)
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
//    MARK: Selection
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
            cellView.backgroundColor = selected ? UIColor(named: "selectedCellColor"): UIColor (named: "cellBackgroundColor")
        }

    
    //MARK: - OTHERS
    override func prepareForReuse() {
        noteLabel.text = nil
       numberLabel.text = nil
    }
}

//    Dlya dodavannya Image do Label

extension UILabel {
  func setImageForLabel(image: UIImage) {
    let attachment = NSTextAttachment()
    attachment.image = image
    attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
    let attachmentStr = NSAttributedString(attachment: attachment)
    let mutableAttributedString = NSMutableAttributedString()
    mutableAttributedString.append(attachmentStr)
    self.attributedText = mutableAttributedString
  }
}






   

