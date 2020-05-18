//
//  DatePickerPopupViewController.swift
//  Sponukannya
//
//  Created by Ben on 19.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit

class DatePickerPopupViewController: UIViewController {


        //MARK: - Constants
        private let mainViewHeight: CGFloat = 300
        private let mainViewWidth: CGFloat = 300
        private let titleLabelHeight: CGFloat = 55
        private let buttonHeight: CGFloat = 55
         private let switchHight: CGFloat = 45
        private let alertViewGrayColor = UIColor (named: "buttonsBorderColor")
            
   
        //MARK: - VARIABLES
    var repeatIsSet: Bool = false
    var transferRepeatIsSet:((Bool) -> ())?
        var dateForCalendar = false
        var setReminder: ((_ components: DateComponents) -> ())?

        
        //MARK: - views
         let backgroundImage = UIImageView()
        let titleLabel = UILabel()
        let datePicker = UIDatePicker()
        let okButton = UIButton()
        let cancelButton = UIButton()
        let switchOnOff = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
        let switchLabel = MyLabel()
        
        let backgroundColorView: UIView = UIView()
        
        let mainView: UIView = {
            let view = UIView()
            if #available(iOS 13.0, *) {
                view.backgroundColor = UIColor (named: "cellBackgroundColor")
             } else {
                // Fallback on earlier versions
             }
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            return view
            }()
        
        
        lazy var buttonStackView: UIStackView  = {
            let stackView = UIStackView(arrangedSubviews: [cancelButton,
                                                           okButton])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            return stackView
        }()
        
       //    delete this code after all debugging is done, this line of code checks if the controller was deallocated from memory
       deinit {
           print("DatePicker was removed from memory")
       }
    
        //MARK: - LIFE CYCLE
        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupLayouts()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
 // MARK: Zatemnennya osnovnogo ekranu
            UIView.animate(withDuration: 1) {
                self.backgroundColorView.alpha = 1.0
            }
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            cancelButton.addBorder(side: .Top, color: alertViewGrayColor!, width: 1)
            cancelButton.addBorder(side: .Right, color: alertViewGrayColor!, width: 0.5)
            okButton.addBorder(side: .Top, color: alertViewGrayColor!, width: 1)
            okButton.addBorder(side: .Left, color: alertViewGrayColor!, width: 0.5)
            titleLabel.addBorderSwitch(side: .Bottom, color: alertViewGrayColor!, width: 1)
        }
        
        
        private func setupViews () {
            
            //backgroundColorView
             setupBackground(imageView: backgroundImage, imageNamed: "background.png", to: self.view)
            view.addSubview(backgroundColorView)
            
            //mainview
            view.addSubview(mainView)
            //titleLabel
            titleLabel.backgroundColor = UIColor (named: "cellBackgroundColor")
            titleLabel.textAlignment = .center
            titleLabel.textColor = UIColor(named: "popaButtonColor")
            titleLabel.font = UIFont(name: NSLocalizedString("Lato-Regular", comment: "Lato-Regular"), size: 25)
            titleLabel.text = NSLocalizedString("Add a reminder", comment: "Add a reminder")
            titleLabel.backgroundColor = .clear
            mainView.addSubview(titleLabel)
            //datePicker
            mainView.addSubview(datePicker)
            //save button
          let okButtonTitle = NSMutableAttributedString(string: "OK", attributes: [
                NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor(named: "popaButtonColor") ?? UIColor.gray
                            ])
                     okButton.setAttributedTitle(okButtonTitle, for: .normal)
            okButton.addTarget(self, action: #selector(oKButtonAction), for: .touchUpInside)
            //cancel button
            let cancelButtonTitle = NSMutableAttributedString(string: "Cancel", attributes: [
                NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24) ,
                 NSAttributedString.Key.foregroundColor: UIColor(named: "popaButtonColor") ?? UIColor.gray
                 ])
                       cancelButton.setAttributedTitle(cancelButtonTitle, for: .normal)
            cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
                mainView.addSubview(buttonStackView)
            //switchLabel
            switchLabel.text = NSLocalizedString("Repeat every day", comment: "Repeat every day")
           switchLabel.font = UIFont(name: NSLocalizedString("Lato-Light", comment: "Lato-Light"),size: 20)
            switchLabel.textColor = UIColor(named: "textColor")
            switchLabel.textAlignment = .left
            self.mainView.addSubview(switchLabel)
            //switch
            switchOnOff.addTarget(self, action: #selector(DatePickerPopupViewController.switchStateDidChange(_:)), for: .valueChanged)
            switchOnOff.setOn(false, animated: false)
            switchOnOff.onTintColor = UIColor (named: "switchONColor")
            switchOnOff.tintColor = .red
            switchOnOff.thumbTintColor = UIColor (named: "switchThumbColor")
            self.mainView.addSubview(switchOnOff)
            
            }
            
        private func setupLayouts () {
            //backgroundColorView
            backgroundColorView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                backgroundColorView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundColorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                backgroundColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            
            //mainView
            mainView.translatesAutoresizingMaskIntoConstraints = false
            
             NSLayoutConstraint.activate([
                mainView.heightAnchor.constraint(equalToConstant: mainViewHeight),
                mainView.widthAnchor.constraint(equalToConstant: mainViewWidth),
                mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                 ])
            
            //titleLabel
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
               titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
               titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
               titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor)
                ])
            
            //datePicker
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                 datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                 datePicker.bottomAnchor.constraint(equalTo:switchLabel.topAnchor),
                 datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            
            //buttonStackView
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                buttonStackView.heightAnchor.constraint(equalToConstant: buttonHeight),
                buttonStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                buttonStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                buttonStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
                ])
            
            // switchLabel
            switchLabel.translatesAutoresizingMaskIntoConstraints = false
                            NSLayoutConstraint.activate([
                switchLabel.heightAnchor.constraint(equalToConstant: switchHight),
                switchLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                switchLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                switchLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor)
                ])
            // switch
            switchOnOff.translatesAutoresizingMaskIntoConstraints = false
                            NSLayoutConstraint.activate([
                                switchOnOff.centerYAnchor.constraint(equalTo: switchLabel.centerYAnchor),
                                 switchOnOff.trailingAnchor.constraint(equalTo: switchLabel.trailingAnchor, constant: -20)
                ])
            }
    
    //MARK:- Reusable Function
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
        }
    
        
        //MARK: - ACTIONS
        @objc func oKButtonAction(_ sender: UIButton) {
                let components = datePicker.calendar.dateComponents([.day, .month, .year, .hour, .minute], from: datePicker.date)
                setReminder!(components)
            transferRepeatIsSet?(repeatIsSet)
                let  message = NSLocalizedString( "The reminder has been successfully created.", comment: "The reminder has been successfully created.")
                presentAlertConfirmation(with: message)
            }
        
        @objc func cancelButtonAction () {
            makeVerticalTransitionFromBottom()
            self.navigationController?.popToRootViewController(animated: true)
            }
        
        @objc func switchStateDidChange(_ sender:UISwitch){
                if (sender.isOn == true){
                    repeatIsSet = true
                }
            

            }
    
        func presentAlertConfirmation (with alertMessage: String) {
            let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                alert.dismiss(animated: true, completion: {[weak self] in
                    self?.makeVerticalTransitionFromBottom()
                    self?.navigationController?.popToRootViewController(animated: true)
                   })
                }
             }
    
    // Custom class MyLabel. Making text marging shob vidstup buv zliva
       class MyLabel: UILabel{
           override func drawText(in rect: CGRect) {
               super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)))
           }
       }
    }

