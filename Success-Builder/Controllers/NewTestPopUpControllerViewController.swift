//
//  UserTextInputViewController.swift
//  Mes Listes
//
//  Created by Anastasiia Tanczak on 18/08/2018.
//  Copyright © 2018 Ana Viktoriv. All rights reserved.
//

import UIKit

class NewTestPopUpControllerViewController: UIViewController {
   
    //MARK: - Views
    
    let backgroundColorView: UIView = UIView()
    
   let mainView: UIView = {
        let view = UIView()
    view.backgroundColor = UIColor (named: "userTextInputVCbackgroundMainView")
        view.layer.cornerRadius = 10

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
    
    let textFieldForInput = UITextField()
    let iconTitleLabel = UILabel()
    let subViewForCollectionView = UIView()

    let okButton = UIButton()
    let cancelButton = UIButton()
    
    

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        textFieldForInput.becomeFirstResponder()
    
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            self.backgroundColorView.alpha = 1.0
        }
        }

    
    private func setupViews () {
   
        backgroundColorView.backgroundColor =
            UIColor.black.withAlphaComponent(0.5)
        backgroundColorView.isOpaque = false
        backgroundColorView.alpha = 0.0
        view.addSubview(backgroundColorView)
        
        //mainview
        view.addSubview(mainView)
        
        //save button
        okButton.setTitle(NSLocalizedString("OK", comment: "OK"), for: .normal)
        okButton.backgroundColor = UIColor.clear
        okButton.setTitleColor(UIColor (named: "popUpButtonFont"), for: .normal)
        okButton.addTarget(self, action: #selector(oKButtonAction), for: .touchUpInside)


        //cancel button
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: "Cancel"), for: .normal)
       cancelButton.setTitleColor(UIColor (named: "popUpButtonFont"), for: .normal)
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)


        mainView.addSubview(buttonStackView)
    }
    
    
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
            mainView.heightAnchor.constraint(equalToConstant: 270),
            mainView.widthAnchor.constraint(equalToConstant: 270),
            mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100)
            ])
        
        //buttonStackView
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
            ])
        
    }


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cancelButton.addBorder(side: .Top, color: .white, width: 2)
        cancelButton.addBorder(side: .Right, color: .white, width: 2)
        okButton.addBorder(side: .Top, color: .white, width: 2)
        okButton.addBorder(side: .Left, color: .white, width: 2)

    }
    


    //MARK: - Button Actions
    @objc func oKButtonAction () {
 print("ok button pressed")
    }
    
    @objc func cancelButtonAction () {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let `self` = self else { return }
            self.backgroundColorView.alpha = 0.0
        }) { [weak self]  (isComplete) in
            guard let `self` = self else { return }
            self.dismiss(animated: true, completion: nil)
            self.textFieldForInput.resignFirstResponder()
        }
    }
    
    



}



