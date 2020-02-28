//
//  MyAffirmationsViewController.swift
//  Sponukannya
//
//  Created by Ben on 10.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit
import CoreData
import MGSwipeTableCell
import UserNotifications



class MyAffirmationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - Properties
         let backgroundImage = UIImageView()
         let titleLabel = UILabel()
         var plusButton = UIButton()
         let tableView = UITableView()
    
    private let cellIdentifier = "MyTableViewCell"
        var myAffis : [MyAffirmationItem] = []
    
//let eventStore = EKEventStore()

    //MARK:- Navigation. Making Navigation Bar Prozzoroyu UND Fetching all Affis
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupView()
         zaraza()
        //  Vyrishennya zatemnenogo backgroundImage
        view.backgroundColor = .white
        }

    //  MARK: - Button ACTIONS
        // addAffiBatton
        @objc func addAffiPopUpButtonPressed(_ sender: UIButton) {
            let addAffiVC = AddAffirmationViewController()
            //Peredacha "zaraza"
           addAffiVC.zaraza = zaraza
            self.navigationController?.pushViewController(addAffiVC, animated: true)
            print("Affa!")
            }
    
    // MARK: CORE DATA SACHEN
    //  MARK: - Fetching z perezavantazhennyam stola
    //   Coreeeeeeeeeeeeeeeeeeeeeeeeee
    func zaraza ()-> (){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        if let coreDataMyAffirmationItems = try? context.fetch(MyAffirmationItem.fetchRequest()) as? [MyAffirmationItem] {
            myAffis = coreDataMyAffirmationItems
        tableView.reloadData()
            print("Fetching")
                }
            }
        }
    
    //  MARK: Setup Layout
        private func setupLayout() {
        setupBackground(imageView: backgroundImage, imageNamed: "background.png", to: self.view)
    
        //titleLabel
        titleLabel.text = "MY AFFIRMATIONS"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 36)
        titleLabel.textColor = UIColor(named: "bigLableTextColor")
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0.0)
        ])
        
        //plusButton
        plusButton.addTarget(self, action: #selector(addAffiPopUpButtonPressed(_:)), for: .touchUpInside)
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
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
        tableView.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 10),
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
           tableView.allowsMultipleSelection = true
           tableView.backgroundColor = UIColor.clear
           tableView.separatorColor = .clear
           tableView.separatorStyle = .singleLine
           tableView.separatorInset = .zero
           tableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
           }
    
    
    
    // MARK: - TableView Sachen
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return myAffis.count
        }

      func configureTableView(){
           tableView.estimatedRowHeight = UITableView.automaticDimension
           }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
                //Prozzorist' of cell
                cell.backgroundColor = .clear
                cell.numberLabel.text = "\(indexPath.row+1)"
            let myAffi = myAffis[indexPath.row]
                cell.noteLabel.text = myAffi.name
       
                cell.selectionStyle = .gray
        //  Selection colour of cell is custom
                   let backgroundView = UIView()
                   backgroundView.backgroundColor = UIColor (named: "switchON")
                   cell.selectedBackgroundView = backgroundView
                cell.layer.cornerRadius = 10
            //  cell.backgroundColor = UIColor.gray
                cell.clipsToBounds = true
          //    cell.swipeBackgroundColor = UIColor.gray
        
//  SWIPE CONFIGURATION
        //configure left buttons
        cell.leftButtons =
        [MGSwipeButton(title: "", icon: UIImage(named:"reminder" ), backgroundColor: UIColor(named: "reminderColor")){
                               [weak self] sender in
           let myAffi = self?.myAffis[indexPath.row].name
            NotificationReminder.body = myAffi ?? ""
            self?.getNotificationSettingStatus()
print("funcAddReminder at indexPath")
                               return true
                               },
         
        MGSwipeButton(title: "", icon: UIImage(named:"edit"), backgroundColor: UIColor(named: "editColor")){
                           [weak self] sender in
            
let popaVC = PopUpViewController ()
   popaVC.modalPresentationStyle = .overCurrentContext
popaVC.transferedAffi = self!.myAffis[indexPath.row]
popaVC.zaraza = self?.zaraza
popaVC.editingAffi = true
popaVC.textNewAffirmation.text = self!.myAffis[indexPath.row].name
print(self?.myAffis[indexPath.row].name)
                                
          
self?.present(popaVC, animated: true, completion: nil)
print("Upa!")
                   
return true
                    }]
                  cell.leftSwipeSettings.transition = .rotate3D

       //configure right button
        cell.rightButtons =
        [MGSwipeButton(title: "", icon: UIImage(named:"trash"), backgroundColor: UIColor(named: "trashColor"), padding: 50) {
                    [weak self] sender in
            let myAffi = self?.myAffis[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(myAffi!)
           (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                        self?.zaraza()
                }
                    return true
                               }]
        cell.rightSwipeSettings.transition = .rotate3D
        cell.rightExpansion.buttonIndex = 0
                
        return cell
    }
    
   
//    func addReminder(at indexpath: IndexPath) {
//        NotificationReminder.body = myAffis[indexpath.row].name ??
//
//           getNotificationSettingStatus()
//       }
    
    

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
    
    
// MARK: ALERTS
    
    func goToSettingsAllert (alertTitle: String, alertMessage: String, alertActionTitle: String, alertCancelActionTitle: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: alertActionTitle, style: .default) {(action) in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        alert.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: alertCancelActionTitle, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
  
//MARK: - NOTIFICATION CENTER MATHODS (REMINDERS)

func getNotificationSettingStatus () {
    
    UNUserNotificationCenter.current().getNotificationSettings {[weak self] (settings) in
        guard let `self` = self else {return}
        
        switch settings.authorizationStatus {
        case .authorized:
            DispatchQueue.main.async {
                // UI work here
                self.goToPopupAndSetReminder()
                
                print("F getNotificationSettingStatus")
            }
        case .denied, .notDetermined, .provisional:
            self.goToSettingsAllert(alertTitle: SettingsAlertNotifications.title, alertMessage: SettingsAlertNotifications.message, alertActionTitle: SettingsAlertNotifications.settingActionTitle, alertCancelActionTitle: SettingsAlertNotifications.cancelActionTitle)
        @unknown default:
            print("unknown case of authorisationStatus")
        }
    }
   
}

func goToPopupAndSetReminder () {
    let dpVC = DatePickerPopupViewController()
    dpVC.dateForCalendar = false
    dpVC.modalPresentationStyle = .overCurrentContext
    dpVC.setReminder = setReminder
    self.present(dpVC, animated: true, completion: nil)
    
    print("F goToPopupAndSetReminder ")
}

func setReminder (_ components: DateComponents) ->(){
    
    let content = UNMutableNotificationContent()
    content.title = NotificationReminder.title
    content.body = NotificationReminder.body
    content.sound = UNNotificationSound.default
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request = UNNotificationRequest(identifier: content.body, content: content, trigger: trigger)
   
print(" NOTIFIC \(NotificationReminder.title)")
print(NotificationReminder.body)

UNUserNotificationCenter.current().add(request) { (error) in
print("Identifier! \(request.identifier)")
        
        if let error = error {
            print(" We had an error: \(error)")
            
        }
    }
}
        
}

