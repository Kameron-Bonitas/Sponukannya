//
//  ViewController.swift
//  Sponukannya
//
//  Created by Anastasiia Tanczak on 18/04/2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit

extension UIViewController {

    func makeVerticalTransitionFromTop(){
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
    }
    
    func makeVerticalTransitionFromBottom(){
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
    }
}
