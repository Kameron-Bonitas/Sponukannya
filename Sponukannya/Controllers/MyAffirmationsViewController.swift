//
//  MyAffirmationsViewController.swift
//  Sponukannya
//
//  Created by Ben on 10.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit

class MyAffirmationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - Properties
         let backgroundImage = UIImageView()
         let titleLabel = UILabel()
         var plusButton = UIButton()
         let tableView = UITableView()
    
         private let cellIdentifier = "MyTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupView()
        
        //  Vyrishennya zatemnenogo backgroundImage
        view.backgroundColor = .white
        
    }

    //  MARK: Setup Layout
        private func setupLayout() {
        setupBackground(imageView: backgroundImage, imageNamed: "background.png", to: self.view)
    
        //titleLabel
        titleLabel.text = "My Affirmations"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 40)
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0.0)
        ])
        
        //plusButton
//        plusButton.addTarget(self, action: #selector(addAffiPopUpButtonPressed(_:)), for: .touchUpInside)
         plusButton.setImage(UIImage(named: "bitmap.png"), for: .normal)
         view.addSubview(plusButton)
        
         plusButton.translatesAutoresizingMaskIntoConstraints = false
       
         NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0.0)
        ])
        // TableView
        // Chomus': <view.addSubview(tableView)> has to be here.Not after <NSLayoutConstraint.activate>
        // because we have constaints conflict. And not after:  <tableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellIdentifier)>, because tableView then is behind the <backgroundImage>!!;))
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 34),
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
     tableView.leadingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
            ])
        }
    
    //    MARK:Setup View
        private func setupView () {
           //tableView
           tableView.delegate = self
           tableView.dataSource = self
           tableView.backgroundColor = UIColor.clear
           tableView.separatorColor = .clear
           tableView.separatorStyle = .singleLine
           tableView.separatorInset = .zero
           tableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
           }
    
    // MARK: - TableView Sachen
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return myAffis.count
        return 4
                }

      func configureTableView(){
           tableView.estimatedRowHeight = UITableView.automaticDimension
           }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
                //Prozzorist' of cell
                cell.backgroundColor = .clear
                cell.numberLabel.text = "\(indexPath.row+1)"
                
                //    Coreeeeeeeeeeeeeeeeeeeeeeeeee
//                let myAffi = myAffis[indexPath.row]
//                cell.noteLabel.text = myAffi.affirmation
                cell.selectionStyle = .none
                cell.layer.cornerRadius = 10
            //  cell.backgroundColor = UIColor.gray
                cell.clipsToBounds = true
          //    cell.swipeBackgroundColor = UIColor.gray
        
             return cell
            }
    
    
    //MARK:- Navigation. Making Navigation Bar Prozzoroyu
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            // Make the navigation bar background clear
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
          navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            }
    

    //MARK:- Reusable Function Background
        func setupBackground(imageView: UIImageView, imageNamed imageName: String, to view: UIView) {
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFill
            view.addSubview(imageView)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
        imageView.bottomAnchor.constraint(equalTo:self.view.bottomAnchor),
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
    //MARK: Castom Font Instance
        guard let customFont = UIFont(name: "Lato-Light", size:UIFont.labelFontSize) else {
            fatalError("""
                        Failed to load the "Lato-Light" font.
                        Make sure the font file is included in the project and the font name is spelled correctly.
                        """)
                }
//        Sho tse nah*j???? NASTYA
        titleLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        titleLabel.adjustsFontForContentSizeCategory = true
            }
        
        

}
