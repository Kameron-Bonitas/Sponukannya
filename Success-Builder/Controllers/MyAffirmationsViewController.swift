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
import StoreKit



class MyAffirmationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - Properties
    let backgroundImage = UIImageView()
    let titleLabel = UILabel()
    var plusButton = UIButton()
    let tableView = UITableView()
    
    private let cellIdentifier = "MyTableViewCell"
    
    //    array that stocks affirmations that come from core data
    var myAffis : [MyAffirmationItem] = []
    var repeatIsSet = Bool ()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate // Prompt Screen
    
    var numberOfUnreadMessage: Int = 0
    
    //MARK:- Navigation. Making Navigation Bar Prozzoroyu UND Fetching all Affis
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchingCoreZaraza()
        
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
        setCategories()
        configureTableView()
        view.backgroundColor = .white //  Vyrishennya zatemnenogo backgroundImage
        countAppLaunchesSwitchOnThem()          // Prompt Screen
    
        }
    
    override func viewDidAppear(_ animated: Bool) {
        if(!appDelegate.hasAlreadyLaunched){
            appDelegate.sethasAlreadyLaunched() //set hasAlreadyLaunched to false
            promptScreen()   //display prompt screen
        }
//            promptScreen()
    }
    
    //  MARK: - Button ACTIONS
    // addAffiBatton
    @objc func addAffiPopUpButtonPressed(_ sender: UIButton) {
        let addAffiVC = AddAffirmationViewController()
        makeVerticalTransitionFromTop()
        self.navigationController?.pushViewController(addAffiVC, animated: true)
        }
    
    // MARK: CORE DATA SACHEN
    //  MARK: - Fetching z perezavantazhennyam stola
    func fetchingCoreZaraza ()-> (){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataMyAffirmationItems = try? context.fetch(MyAffirmationItem.fetchRequest()) as? [MyAffirmationItem] {
                myAffis = coreDataMyAffirmationItems
                tableView.reloadData()
            }
        }
    }
    
    //  MARK: Setup Layout
    private func setupLayout() {
        setupBackground(imageView: backgroundImage, imageNamed: "background.png", to: self.view)
        
        //titleLabel
        titleLabel.text = NSLocalizedString( "My Affirmations", comment: "My Affirmations")
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 40)
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
//  ?????????????????????????????????????????????????????????????????????????
        //        tableView.estimatedRowHeight = 400.0
        //        tableView.rowHeight = UITableView.automaticDimension
        
        //           tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        //Prozzorist' of cell
        cell.backgroundColor = .clear
        cell.numberLabel.text = "\(indexPath.row+1)"
        let myAffi = myAffis[indexPath.row]
        cell.noteLabel.text = myAffi.name
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        
        //  SWIPE CONFIGURATION
        //configure left buttons
        cell.leftButtons =
            [MGSwipeButton(title: "", icon: UIImage(named:"reminder" ), backgroundColor: UIColor.clear){
                [weak self] sender in
                let myAffi = self?.myAffis[indexPath.row].name
                NotificationReminder.body = myAffi ?? ""
                self?.getNotificationSettingStatus()
                return true
                },
             
             MGSwipeButton(title: "", icon: UIImage(named:"edit"), backgroundColor: UIColor.clear){
                [weak self] sender in
                let popaVC = PopUpViewController ()
                popaVC.modalPresentationStyle = .overCurrentContext
            popaVC.transferedAffi = self!.myAffis[indexPath.row]
                popaVC.editingAffi = true
            popaVC.textNewAffirmation.text = self!.myAffis[indexPath.row].name
                self?.makeVerticalTransitionFromTop()
                self?.navigationController?.pushViewController(popaVC, animated: true)
                return true
                }]
        cell.leftSwipeSettings.transition = .rotate3D
        
        //configure right button
        cell.rightButtons =
            [MGSwipeButton(title: "", icon: UIImage(named:"trash"), backgroundColor: UIColor.clear, padding: 50) {
                [weak self] sender in
                let myAffi = self?.myAffis[indexPath.row]
                if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    context.delete(myAffi!)
                    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                    self?.fetchingCoreZaraza()
                }
                return true
                }]
        cell.rightSwipeSettings.transition = .rotate3D
        cell.rightExpansion.buttonIndex = 0
        
        return cell
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
        guard let customFont = UIFont(name: "Lato-Regular", size:UIFont.labelFontSize) else {
            fatalError("""
                        Failed to load the "Lato-Light" font.
                        Make sure the font file is included in the project and the font name is spelled correctly.
                        """)
        }
      
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
        makeVerticalTransitionFromTop()
        self.navigationController?.pushViewController(dpVC, animated: true)
        
        //with this code we assing a closure to a variable in datePicker that has the type of closure, it then transfers the value we get from the switch into the local value repeatIsSet which we use later to send notifications
        dpVC.transferRepeatIsSet = { [weak self] in
            guard let `self` = self else {return}
            //the $0 refers to the param which we get in datePicker when we pass the local repeatIsSet (the one in datePicker)
            self.repeatIsSet = $0
             }
          }
    
    func setReminder (_ components: DateComponents) ->(){
        let content = UNMutableNotificationContent()
        content.title = NotificationReminder.title
        content.body = NotificationReminder.body
        content.sound = UNNotificationSound.default
        content.badge = 0
//        content.badge = NSNumber (value: UIApplication.shared.applicationIconBadgeNumber + 1)
        content.categoryIdentifier = "alarm.category"
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: repeatIsSet)
        let request = UNNotificationRequest(identifier: content.body, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print("repeatIsSet = \(self.repeatIsSet)")
            if let error = error {
                print(" We had an error: \(error)")
            }
        }
    }
    
    //MARK: - Functions // Notification Action. Defining Actions. "Do Not Repeat"
    func setCategories(){
        let doNotRepeatAction = UNNotificationAction(identifier: "Do Not Repeat", title: "Do Not Repeat", options: [])
        
        let alarmCategory = UNNotificationCategory(identifier: "alarm.category",actions: [doNotRepeatAction],intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }

    
    //MARK: - DIFFERENT METHODS
    func countAppLaunchesSwitchOnThem () {
        let currentCount = appLaunchCount()
        switch currentCount {
        case 10, 50, 100:
            promtForReview()
            fetchingCoreZaraza()
            tableView.reloadData()
        default:
            fetchingCoreZaraza()
            tableView.reloadData()
        }
    }
    
    func appLaunchCount() -> Int {
        var currentCount = UserDefaults.standard.integer(forKey: "launchCount")
        currentCount += 1
        UserDefaults.standard.set(currentCount, forKey: "launchCount")
        return currentCount
    }
    
    func promtForReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    func promptScreen(){
        let prVC = PromptScreenViewController()
        makeVerticalTransitionFromTop()
        self.navigationController?.pushViewController(prVC, animated: true)
    }
    
}

