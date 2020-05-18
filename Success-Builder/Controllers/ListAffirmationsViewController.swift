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
    let cellId = "ListTableViewCell"
    
    let backgroundColorView: UIView = UIView()
    
    var selectedAffis = [String]()
    
    // Pryklady Affirmations (hardcoded)
    private var sampleAffis = [
    NSLocalizedString("Smile at yourself!",comment: "Smile at yourself!"),
    NSLocalizedString("I am the best!",comment: "I am the best!"),
    NSLocalizedString("I am secure and safe in the world.",comment: "I am secure and safe in the world."),
    NSLocalizedString("My capability and potential are endless.",comment: "My capability and potential are endless."),
    NSLocalizedString("I am a great person.",comment: "I am a great person."),
    NSLocalizedString("I believe in myself. I can succeed.",comment: "I believe in myself. I can succeed."),
    NSLocalizedString("I can accomplish anything I set my mind to.",comment: "I can accomplish anything I set my mind to."),
    NSLocalizedString("I love who I have become.",comment: "I love who I have become."),
    NSLocalizedString("I am confident and brave. I live in the present, and I look forward to the future.",comment: "I am confident and brave. I live in the present, and I look forward to the future."),
    NSLocalizedString("I feel great about myself and my life.",comment: "I feel great about myself and my life."),
    NSLocalizedString("My life is abundant and full of joy.",comment:"My life is abundant and full of joy."),
    NSLocalizedString("I deserve to be happy and successful.",comment: "I deserve to be happy and successful."),
    NSLocalizedString("I can trust myself to handle anything.",comment: "I can trust myself to handle anything."),
    NSLocalizedString("I recognize the many good qualities I have.",comment: "I recognize the many good qualities I have."),
    NSLocalizedString("I trust myself. I am excellent exactly as I am.",comment: "I trust myself. I am excellent exactly as I am."),
    NSLocalizedString("I accept myself and know that I am worthy of great things in life.",comment: "I accept myself and know that I am worthy of great things in life."),
    NSLocalizedString("I have the knowledge and resources to achieve my dreams.",comment: "I have the knowledge and resources to achieve my dreams."),
    NSLocalizedString("I am releasing all of my fears and worries. I am living my full potential.",comment: "I am releasing all of my fears and worries. I am living my full potential."),
    NSLocalizedString("I feel tremendous confidence that I can do anything.",comment: "I feel tremendous confidence that I can do anything."),
    NSLocalizedString("I see problems as challenges that evolve me and make me grow.",comment: "I see problems as challenges that evolve me and make me grow."),
    NSLocalizedString("I am willing to step out of my comfort zone.",comment: "I am willing to step out of my comfort zone."),
    NSLocalizedString("I have the energy I need to accomplish my goals and to fulfill my desires.",comment: "I have the energy I need to accomplish my goals and to fulfill my desires."),
    NSLocalizedString("New ideas come to me regularly.",comment: "New ideas come to me regularly."),
    NSLocalizedString("I choose happiness no matter what the circumstances are.",comment: "I choose happiness no matter what the circumstances are."),
    NSLocalizedString("I work for the good of others.",comment: "I work for the good of others."),
    NSLocalizedString("I am positive-minded and filled with self-esteem.",comment: "I am positive-minded and filled with self-esteem."),
    NSLocalizedString("I think only positive things about people. I accept that everyone does their best.",comment: "I think only positive things about people. I accept that everyone does their best."),
    NSLocalizedString("I have something special to offer the world.",comment: "I have something special to offer the world."),
    NSLocalizedString("My future depends only on me!", comment: "My future depends only on me!")
]
    
    
    
    //    delete this code after all debugging is done, this line of code checks if the controller was deallocated from memory
    deinit {
        print("ListAffirmationsController was removed from memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupView ()
        configureTableView()
        view.backgroundColor = .white
        }
    
    //MARK: - Button ACTIONS
    // Cancel Batton
    @objc func cancelButtonPressed(_ sender: UIButton) {
        makeVerticalTransitionFromBottom()
        self.navigationController?.popViewController(animated: true)
     }
    
    // Add Button
    @objc func addButtonPressed(_ sender: UIButton) {
         if selectedAffis.count > 0 {
    // Rishennya pro poslidovne zberigannya vybranyh selektnutyh z selectedAffis
    // for in loop
    for affiToAdd in selectedAffis {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let newMyAffirmation = MyAffirmationItem(context: context)
            newMyAffirmation.name = affiToAdd
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
    // Povertannya do golovnogo (myAffi)
        makeVerticalTransitionFromBottom()
        self.navigationController?.popToRootViewController( animated: true)
         } else {
            UIView.animate(withDuration: 1) {
                       self.backgroundColorView.alpha = 1.0
                              }
            UIView.animate(withDuration: 2, animations: { [weak self] in
                guard let `self` = self else { return }
               let  message = NSLocalizedString("You haven't choosen your affirmations yet.", comment: "You haven't choosen your affirmations yet."); self.presentAlertConfirmation(with: message)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: Setup Layot
       private func setupLayout() {
       setupBackground(imageView: backgroundImage, imageNamed: "background.png", to: self.view)
        //titleLabel
        titleLabel.text = NSLocalizedString("Choose Affirmations", comment: "Choose Affirmations")
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 40)
        titleLabel.textColor = UIColor(named: "bigLableTextColor")
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0.0)
                  ])
        //cancelButton
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: "Cancel"), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 30)
        cancelButton.backgroundColor = UIColor(named: "bigButtonColor")
        cancelButton.setTitleColor(UIColor (named: "bigButtonTextColor"), for: .normal)
        cancelButton.layer.cornerRadius = 5
        cancelButton.clipsToBounds = true
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        cancelButton.heightAnchor.constraint(equalToConstant: 62),
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-50),
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
        cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5)
           ])
        //addlButton
        addButton.setTitle(NSLocalizedString("Add", comment: "Add"), for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 30)
        addButton.backgroundColor = UIColor(named: "bigButtonColor")
        addButton.setTitleColor(UIColor (named: "bigButtonTextColor"), for: .normal)
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
       tableView.register(ListTableViewCell.self, forCellReuseIdentifier: cellId)
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
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListTableViewCell
            //Prozzorist' of cell
            cell.backgroundColor = .clear
            let content = sampleAffis[indexPath.row]
            cell.noteLabel.text = content
        
        cell.numberLabel.setImageForLabel(image: UIImage(named: "CircleImage")!)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        //  Selection colour of cell is custom
         cell.selectionStyle = .none
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
    
    //MARK: Poperedzhennya z povidomlennyam
        // Dlya Add button, koly ne Vybrano.
    func presentAlertConfirmation (with alertMessage: String) {
               let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
               self.present(alert, animated: true, completion: nil)
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   alert.dismiss(animated: true, completion: {[weak self] in
                    self!.dismiss(animated: true, completion: nil)
                      })
                }
           }
    }
