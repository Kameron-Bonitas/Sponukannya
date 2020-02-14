//
//  PopUpViewController.swift
//  Sponukannya
//
//  Created by Ben on 10.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    //MARK: Constants
        var reloadTable:(()->())?
        var dismissAddAffi:(()->())?
        
        let textNewAffirmation = UITextView()
        let okButton = UIButton()
        let cancelButton = UIButton()
        let placeholder = "Type your affirmation here..."

        let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
        let textViwBorderWidth: CGFloat = 0.5
        let textViwBorderColor = UIColor.init(red: 200/255, green: 199/255, blue: 204/255, alpha: 1)
        let textViwFontSize: CGFloat = 18
        
    lazy var buttonStackView: UIStackView  = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton,
                                                            okButton])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            return stackView
         }()
    
    //MARK: - Views
    let backgroundColorView: UIView = UIView()
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor (named: "popaBackground")
        view.layer.cornerRadius = 10
        return view
    }()

   //MARK: - Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupLayouts()
            placeHolder ()
            textNewAffirmation.becomeFirstResponder()
            }
    
    //MARK: - Button Actions
    // OK Button
    @objc func oKButtonAction () {
        if textNewAffirmation.text != placeholder && textNewAffirmation.text != nil {

            self.save(name: textNewAffirmation.text)
            

            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let `self` = self else { return }
                self.backgroundColorView.alpha = 0.0
            }) { [weak self]  (isComplete) in
                guard let `self` = self else { return }
                self.dismiss(animated: true, completion: nil)
                self.textNewAffirmation.resignFirstResponder()
            }
            // Vmykannya "zaraza" (zberigannya i fetching v table)
               // Povertannya v MyAffirm...ViewController
               reloadTable? ()
               dismissAddAffi? ()
               print("Save")

            }else if textNewAffirmation.text == placeholder && textNewAffirmation.text != nil{
                UIView.animate(withDuration: 2, animations: { [weak self] in
                    guard let `self` = self else { return }
                    self.textNewAffirmation.backgroundColor = UIColor.init(red: 240/255, green: 214/255, blue: 226/255, alpha: 1)
                   let  message = NSLocalizedString("You haven't created your new affirmation yet.", comment: "You haven't created your new affirmation yet."); self.presentAlertConfirmation(with: message)
                    self.view.layoutIfNeeded()
                })

                UIView.animate(withDuration: 2, animations: { [weak self] in
                    guard let `self` = self else { return }
                    self.textNewAffirmation.backgroundColor = .clear
                    self.view.layoutIfNeeded()
                })

            }else{
                print("text field is nill")
            }
           }

    //Cancel Button
    @objc func cancelButtonAction () {
    UIView.animate(withDuration: 0.3, animations: { [weak self] in
                   guard let `self` = self else { return }
                   self.backgroundColorView.alpha = 0.0
               }) { [weak self]  (isComplete) in
                   guard let `self` = self else { return }
                   self.dismiss(animated: true, completion: nil)
                   self.textNewAffirmation.resignFirstResponder()
               }
            }
        
    
    // MARK: CoreData Functions
    // Insert
      func save(name: String) {
        let _ = CoreDataManager.sharedManager.insertAffirmation(name: name)
        print("II. Mon Affi Saved")
        }

   //MARK: SetupLayouts
    private func setupLayouts () {
        //backgroundColorView
        backgroundColorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
              backgroundColorView.topAnchor.constraint(equalTo: self.view.topAnchor),
              backgroundColorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
              backgroundColorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
              backgroundColorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ])
        //mainView
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                mainView.heightAnchor.constraint(equalToConstant:200),
                mainView.widthAnchor.constraint(equalToConstant: 340),
                mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100)
                ])
        //textFieldForInput
        textNewAffirmation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                textNewAffirmation.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
                textNewAffirmation.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
                textNewAffirmation.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
                ])
        //buttonStackView
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                buttonStackView.topAnchor.constraint(equalTo: textNewAffirmation.bottomAnchor, constant: 10),
                buttonStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                buttonStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                buttonStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
                ])
                }
    
    //MARK: Setup Views func
    private func setupViews () {
        //backgroundColorView
        backgroundColorView.backgroundColor = UIColor.black.withAlphaComponent(0.34)
                backgroundColorView.isOpaque = false
                backgroundColorView.alpha = 0.0
                view.addSubview(backgroundColorView)
        //mainview
        view.addSubview(mainView)
        //textView
        textNewAffirmation.backgroundColor = .clear
        textNewAffirmation.font = UIFont.systemFont(ofSize: textViwFontSize, weight: .light)
        textNewAffirmation.returnKeyType = .done
        //save button
        okButton.setTitle(NSLocalizedString("OK", comment: "OK"), for: .normal)
        okButton.backgroundColor = UIColor.clear
        okButton.setTitleColor(UIColor.black, for: .normal)
        okButton.addTarget(self, action: #selector(oKButtonAction), for: .touchUpInside)
        //cancel button
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: "Cancel"), for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.backgroundColor = UIColor.clear
                cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
            
        [textNewAffirmation, buttonStackView,].forEach { mainView.addSubview($0) }
                }
    //MARK: Layout Subviews
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            cancelButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
            cancelButton.addBorder(side: .Right, color: alertViewGrayColor, width: 0.5)
            okButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
            okButton.addBorder(side: .Left, color: alertViewGrayColor, width: 0.5)
            }
    
    //MARK: Placeholder func
    func placeHolder () {
        textNewAffirmation.delegate = self as? UITextViewDelegate
         textNewAffirmation.text = placeholder
         textNewAffirmation.textColor = UIColor.lightGray
         //Kursor na pochatku placeholder'a
         textNewAffirmation.selectedTextRange = textNewAffirmation.textRange(from:textNewAffirmation.beginningOfDocument, to: textNewAffirmation.beginningOfDocument)
        textNewAffirmation.becomeFirstResponder()
        }
    
    }

//MARK: EXTENSION
//MARK: Placeholder
    // Placeholder disappearing when start typing
extension PopUpViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText: NSString = textView.text! as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        if updatedText.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textNewAffirmation.beginningOfDocument, to: textNewAffirmation.beginningOfDocument)
            return false
        }else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        return true
        }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textNewAffirmation.beginningOfDocument, to: textNewAffirmation.beginningOfDocument)
                }
            }
        }
   
//MARK: Poperedzhennya z povidomlennyam
        // Dlya OK button, koly ne napysano.
    func presentAlertConfirmation (with alertMessage: String) {
               let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
               self.present(alert, animated: true, completion: nil)
               
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   alert.dismiss(animated: true, completion: {[weak self] in
                       // Dismiss ves'popaVC
                       //self!.dismiss(animated: true, completion: nil)
                      })
                }
           }
    
}




