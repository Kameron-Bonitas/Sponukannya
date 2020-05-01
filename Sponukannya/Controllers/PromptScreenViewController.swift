//
//  PromptScreenViewController.swift
//  Sponukannya
//
//  Created by Ben on 30.03.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit

class PromptScreenViewController: UIViewController {
    
    let backgroundImage = UIImageView()
    let gotItButton = UIButton()
    let titleLabel = UILabel()
    let thenLabel = UILabel()
    let chooseLabel = UILabel()
    let setLabel = UILabel()
    let repeatLabel = UILabel()
    let backgroundColorView: UIView = UIView()
    
    //    delete this code after all debugging is done, this line of code checks if the controller was deallocated from memory
    deinit {
        print("PromptController was removed from memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        
    }
    
    //    SetupView
    func setupView() {
        //backgroundColorView shob ne bulo vydno bat'kivs'kyj VC
        backgroundColorView.backgroundColor = UIColor.white.withAlphaComponent(1)
        backgroundColorView.isOpaque = false
        view.addSubview(backgroundColorView)
        
        // Background View
        setupBackground(imageView: backgroundImage, imageNamed: "promptscreen.png", to: self.view)
        
        //Got It button
        gotItButton.setTitle(NSLocalizedString("Got It", comment: "Got It"), for: .normal)
        gotItButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 30)
        gotItButton.backgroundColor = UIColor(named: "bigButtonColor")
        gotItButton.setTitleColor(UIColor (named: "affiButtonText"), for: .normal)
        gotItButton.layer.cornerRadius = 10.0
        gotItButton.addTarget(self, action: #selector(gotItButtonAction), for: .touchUpInside)
        self.view.addSubview(gotItButton)
        
        //titleLabel
        titleLabel.text = NSLocalizedString("Are you ready to become successful and confident?", comment: "Are you ready to become successful and confident?")
        titleLabel.textColor = UIColor(named: "popaButtonColor")
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 30)
        self.view.addSubview(titleLabel)
        
        //thenLabel
        thenLabel.text = NSLocalizedString("Then:", comment: "Then:")
        thenLabel.textColor = UIColor(named: "popaButtonColor")
        thenLabel.backgroundColor = .clear
        thenLabel.textAlignment = .center
        //        thenLabel.font = UIFont(name: thenLabel.font.fontName, size: 30)
        thenLabel.font = UIFont(name: thenLabel.font.fontName, size: 30)
        self.view.addSubview(thenLabel)
        
        //chooseLabel
        chooseLabel.text = NSLocalizedString("1.Choose ypur positive affirmations", comment: "1.Choose ypur positive affirmations")
        chooseLabel.textColor = UIColor(named: "popaButtonColor")
        chooseLabel.backgroundColor = .clear
        chooseLabel.textAlignment = .center
        chooseLabel.numberOfLines = 0
        chooseLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        chooseLabel.sizeToFit()
        chooseLabel.font = UIFont(name: chooseLabel.font.fontName, size: 30)
        self.view.addSubview(chooseLabel)
        //setLabel
        setLabel.text = NSLocalizedString("2.Set reminders", comment: "2.Set reminders")
        setLabel.textColor = UIColor(named: "popaButtonColor")
        setLabel.backgroundColor = .clear
        setLabel.textAlignment = .center
        setLabel.font = UIFont(name:setLabel.font.fontName, size: 30)
        self.view.addSubview(setLabel)
        
        //repeatLabel
        repeatLabel.text = NSLocalizedString("3.Repeat them as often as you wish", comment: "3.Repeat them as often as you wish")
        repeatLabel.textColor = UIColor(named: "popaButtonColor")
        repeatLabel.backgroundColor = .clear
        repeatLabel.textAlignment = .center
        repeatLabel.numberOfLines = 0
        repeatLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        repeatLabel.sizeToFit()
        repeatLabel.font = UIFont(name: repeatLabel.font.fontName, size: 30)
        self.view.addSubview(repeatLabel)
    }
    
    //    Setup Layout
    func setupLayout(){
        //BackgroundColorView
        backgroundColorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundColorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            backgroundColorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundColorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        //Titel Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        ])
        //Then Label
        thenLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thenLabel.heightAnchor.constraint(equalToConstant: 60),
            thenLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            thenLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            thenLabel.bottomAnchor.constraint(equalTo: chooseLabel.topAnchor)
        ])
        //Choose Label
        chooseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseLabel.heightAnchor.constraint(equalToConstant: 80),
            chooseLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            chooseLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            chooseLabel.bottomAnchor.constraint(equalTo: setLabel.topAnchor)
        ])
        //Set Label
        setLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setLabel.heightAnchor.constraint(equalToConstant: 60),
            setLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            setLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            setLabel.bottomAnchor.constraint(equalTo: repeatLabel.topAnchor)
        ])
        //Repeat Label
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repeatLabel.heightAnchor.constraint(equalToConstant: 80),
            repeatLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            repeatLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            repeatLabel.bottomAnchor.constraint(equalTo: gotItButton.topAnchor, constant: -80)
        ])
        
        //gotItButton button
        gotItButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gotItButton.heightAnchor.constraint(equalToConstant: 62),
            gotItButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -70),
            gotItButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 70),
            gotItButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
        ])
    }
    
    // Button function
    @objc func gotItButtonAction() {
        makeVerticalTransitionFromBottom()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    //    /MARK:- Reusable Function
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
        // Vykorystovuyem ves' snipet vklyuchno z = true
        guard let customFont = UIFont(name: "Lato-Regular", size: UIFont.labelFontSize) else {
            fatalError("""
                    Failed to load the "Lato-Regular" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """)
        }
        titleLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        guard let customFontA = UIFont(name: "Lato-light", size: UIFont.labelFontSize) else {
            fatalError("""
            Failed to load the "Lato-Light" font.
            Make sure the font file is included in the project and the font name is spelled correctly.
            """)
        }
        
        thenLabel.font = UIFontMetrics.default.scaledFont(for: customFontA)
        thenLabel.adjustsFontForContentSizeCategory = true
        chooseLabel.font = UIFontMetrics.default.scaledFont(for: customFontA)
        chooseLabel.adjustsFontForContentSizeCategory = true
        setLabel.font = UIFontMetrics.default.scaledFont(for: customFontA)
        setLabel.adjustsFontForContentSizeCategory = true
        repeatLabel.font = UIFontMetrics.default.scaledFont(for: customFontA)
        repeatLabel.adjustsFontForContentSizeCategory = true
    }
    
}

