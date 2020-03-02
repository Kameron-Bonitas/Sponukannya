//
//  LisrAffirmationsViewController.swift
//  Sponukannya
//
//  Created by Ben on 10.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit
import CoreData

class ListAffirmationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    let cancelButton = UIButton()
    let addButton = UIButton()
    let tableView = UITableView()
    let cellId = "MyTableViewCell"
    
    var selectedAffis = [String]()
    
    // Pryklady Affirmations (hardcoded)
    private var sampleAffis = ["This is a short text.", "This is another text, and it is a little bit longer.", "Wow, this text is really very very long! I hope it can be read completely! Luckily, we are using automatic row height!", "Важлива інформація!Марш Захисників України вже завтра, тому пропонуємо ознайомитись з фінальним інструктажем!1. Збір починається о 10:00 в парку Тараса Шевченка, навпроти Червоного корпусу університету.Слава Україні!","It looks like there is now cirilic version for diese blöde Lato Macciato Fonts", "Dysplaying AFFIRMATIONS in ukraine language is impossible!!!!!!!!!"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupView ()
        view.backgroundColor = .white
        }
    
    //MARK: - Button ACTIONS
    // Cancel Batton
    @objc func cancelButtonPressed(_ sender: UIButton) {
    // Povertannya do golovnogo (myAffi)
    let myAffiVC = MyAffirmationsViewController()
    self.navigationController?.pushViewController(myAffiVC, animated: true)
    }
    // Add Button
    @objc func addButtonPressed(_ sender: UIButton) {
    // Rishennya pro poslidovne zberigannya vybranyh selektnutyh z selectedAffis
    // for in loop
    for affiToAdd in selectedAffis {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let newMyAffirmation = MyAffirmationItem(context: context)
            newMyAffirmation.name = affiToAdd
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        self.tableView.reloadData()
        }
    // Povertannya do golovnogo (myAffi)
    let myAffiVC = MyAffirmationsViewController()
    self.navigationController?.pushViewController(myAffiVC, animated: true)
    
    }
    
            
    // MARK: Setup Layot
       private func setupLayout() {
       setupBackground(imageView: backgroundImage, imageNamed: "background.png", to: self.view)
        //titleLabel
        titleLabel.text = "CHOOSE AFFIRMATIONS"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 36)
        titleLabel.textColor = UIColor(named: "bigLableTextColor")
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0.0)
                  ])
        //cancelButton
//        cancelButton.backgroundColor = .systemBlue
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: "Cancel"), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 30)
        cancelButton.backgroundColor = UIColor(named: "bigButtonColor")
        cancelButton.setTitleColor(UIColor (named: "textColor"), for: .normal)
//        cancelButton.tintColor = .white
        cancelButton.layer.cornerRadius = 5
        cancelButton.clipsToBounds = true
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        cancelButton.heightAnchor.constraint(equalToConstant: 62),
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-47),
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
        cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5)
           ])
        //addlButton
//        addButton.backgroundColor = .systemBlue
        addButton.setTitle(NSLocalizedString("Add", comment: "Add"), for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 30)
        addButton.backgroundColor = UIColor(named: "bigButtonColor")
        addButton.setTitleColor(UIColor (named: "textColor"), for: .normal)
//        addButton.tintColor = .white
        addButton.layer.cornerRadius = 5
        addButton.clipsToBounds = true
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        addButton.heightAnchor.constraint(equalToConstant: 62),
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-50),
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
        addButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5)
           ])
        // table
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 150.0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        }
    
    //   MARK:Setup View
    private func setupView () {
       //tableView
       tableView.delegate = self
       tableView.dataSource = self
       tableView.allowsMultipleSelection = true
       tableView.backgroundColor = UIColor.clear
       tableView.separatorColor = .clear
       tableView.separatorStyle = .singleLine
       tableView.separatorInset = .zero
       tableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellId)
       }
    
   
    
    // MARK: - TableView Sachen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleAffis.count
        }

    //Zberigayemo v selectedAffis vybranyj sampleAffi
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAffis.append(sampleAffis[indexPath.row])
        }
    
    // Removing from selectedAffis, koly user deselektnuv cell
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = selectedAffis.firstIndex(of: sampleAffis[indexPath.row]) {
            selectedAffis.remove(at: index)
            }
        }
    
    func configureTableView(){
            tableView.estimatedRowHeight = UITableView.automaticDimension
            print("configureTableView")
                }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyTableViewCell
            //Prozzorist' of cell
            cell.backgroundColor = .clear
            let content = sampleAffis[indexPath.row]
            cell.noteLabel.text = content
        cell.numberLabel.text = "❊"
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
        //  Selection colour of cell is custom
         cell.selectionStyle = .gray
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor (named: "selectedListCellColor")
        cell.selectedBackgroundView = backgroundView
            return cell
         }


    //MARK:- Reusable Function Background
       func setupBackground(imageView: UIImageView, imageNamed imageName: String, to view: UIView) {
           imageView.image = UIImage(named: imageName)
           imageView.contentMode = .scaleAspectFill
           view.addSubview(imageView)
           imageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               imageView.topAnchor.constraint(equalTo: view.topAnchor),
               imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor ),
               imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
               imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])
        //MARK: Castom Font Instance
        // Vykorystovuyem ves' snipet vklyuchno z = true
           guard let customFont = UIFont(name: "Lato-Light", size: UIFont.labelFontSize) else {
               fatalError("""
                   Failed to load the "Lato-Light" font.
                   Make sure the font file is included in the project and the font name is spelled correctly.
                   """)
               }
           titleLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
           titleLabel.adjustsFontForContentSizeCategory = true
           }
    
    
}
