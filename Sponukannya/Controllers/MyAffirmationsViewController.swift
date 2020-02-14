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



class MyAffirmationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - Properties
         let backgroundImage = UIImageView()
         let titleLabel = UILabel()
         var plusButton = UIButton()
         let tableView = UITableView()
    
         private let cellIdentifier = "MyTableViewCell"
         var myAffis : [MyAffirmationItem] = []

    //MARK:- Navigation. Making Navigation Bar Prozzoroyu UND Fetching all Affis
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        //Fetching all Affis
        fetchAllAffirmations()
        }
    
    override func viewWillDisappear(_ animated: Bool) {
               super.viewWillDisappear(animated)
               }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupView()
        
        //  Vyrishennya zatemnenogo backgroundImage
        view.backgroundColor = .white
        }

    //  MARK: - Button ACTIONS
        // addAffiBatton
        @objc func addAffiPopUpButtonPressed(_ sender: UIButton) {
            let addAffiVC = AddAffirmationViewController()
    //        addAffiVC.modalPresentationStyle = .overCurrentContext
//            addAffiVC.zaraza = zaraza
    //        self.present(addAffiVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(addAffiVC, animated: true)
        print("Affa!")
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
        plusButton.addTarget(self, action: #selector(addAffiPopUpButtonPressed(_:)), for: .touchUpInside)
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
    
    // MARK: CoreData Functions
       // Insert
         func save(name: String) {
           let _ = CoreDataManager.sharedManager.insertAffirmation(name: name)
           print("I. Choosen Affi Saved")
           }
        // Delete
        func delete(name : MyAffirmationItem){
            CoreDataManager.sharedManager.delete(affirmation: name)
    }
       
       //Fetch All Affirmations
       /*init fetchedResultsController and set self as delegate, also you need to implement delegate methods*/
       func fetchAllAffirmations(){
           /*This class is delegate of fetchedResultsController protocol methods*/
           
           CoreDataManager.sharedManager.fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
         do{
           print("2. NSFetchResultController will start fetching :)")
           /*initiate performFetch() call on fetchedResultsController*/
           try CoreDataManager.sharedManager.fetchedResultsController.performFetch()
           print("3. NSFetchResultController did end fetching :)")

         }catch{
           print(error)
         }
         
       }
       
//       func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//           
//           print("B. NSFetchResultController didChange NSFetchedResultsChangeType \(type.rawValue):)")
//
//           
//           switch (type) {
//           case .insert:
//             if let indexPath = newIndexPath {
//               tableView.insertRows(at: [indexPath], with: .fade)
//             }
//             break;
//           case .delete:
//             if let indexPath = indexPath {
//               tableView.deleteRows(at: [indexPath], with: .fade)
//             }
//             break;
//           case .update:
//            if let indexPath = indexPath,let cell = tableView.cellForRow(at: indexPath)  {
//                var ncell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
//                configureCell(ncell, at: indexPath)
//                
//             }
//             break;
//             
//           case .move:
//             if let indexPath = indexPath {
//               tableView.deleteRows(at: [indexPath], with: .fade)
//             }
//             
//             if let newIndexPath = newIndexPath {
//               tableView.insertRows(at: [newIndexPath], with: .fade)
//             }
//             break;
//             
//           @unknown default:
//               fatalError()
//           }
//       }
//         
//         /*The last delegate call*/
//         func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//           /*finally balance beginUpdates with endupdates*/
//           tableView.endUpdates()
//         }
//       
//    
//    
    // MARK: - TableView Sachen
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return myAffis.count
        /*fetchResultController's .section method returns array of NSFetchedResultsSectionInfo objects. As we have not provided any section info, sections */
        guard let sections = CoreDataManager.sharedManager.fetchedResultsController.sections else {
          return 0
        }
        
        /*get number of rows count for each section*/
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
        }

      func configureTableView(){
           tableView.estimatedRowHeight = UITableView.automaticDimension
           }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
                //Prozzorist' of cell
                cell.backgroundColor = .clear
                cell.numberLabel.text = "\(indexPath.row+1)"
            
        configureCell(cell, at: indexPath)
                cell.selectionStyle = .none
                cell.layer.cornerRadius = 10
            //  cell.backgroundColor = UIColor.gray
                cell.clipsToBounds = true
          //    cell.swipeBackgroundColor = UIColor.gray
        
//  SWIPE CONFIGURATION
        //configure left buttons
        cell.leftButtons =
        [MGSwipeButton(title: "", icon: UIImage(named:"bitmap" ), backgroundColor: .green){
                               [weak self] sender in
        
                               return true
                               },
        MGSwipeButton(title: "Edit", backgroundColor: .blue){
                           [weak self] sender in
                          
                           return true
                              }]
                  cell.leftSwipeSettings.transition = .rotate3D

        //configure right button
        cell.rightButtons =
        [MGSwipeButton(title: "Delete", backgroundColor: .red, padding: 50) {
                    [weak self] sender in
            let myAffi = CoreDataManager.sharedManager.fetchedResultsController.object(at: indexPath)
            self?.delete(name:myAffi)
           self?.tableView.reloadData()
//            self?.fetchAllAffirmations()
            print("Delete myAffi")
                    return true
                               }]
        cell.rightSwipeSettings.transition = .rotate3D
        cell.rightExpansion.buttonIndex = 0
                
        return cell
    }
    
    func configureCell(_ cell: MyTableViewCell, at indexPath: IndexPath) {
      /*get managed object*/
      let myAffi = CoreDataManager.sharedManager.fetchedResultsController.object(at: indexPath)
        // Configure Cell
      cell.noteLabel.text = myAffi.name
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

extension MyAffirmationsViewController  : NSFetchedResultsControllerDelegate{
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    /*This delegate method will be called first.As the name of this method "controllerWillChangeContent" suggets write some logic for table view to initiate insert row or delete row or update row process. After beginUpdates method the next call will be for :
     
     - (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath
     
     */
    print("A. NSFetchResultController controllerWillChangeContent :)")

    tableView.beginUpdates()
  }
  
  /*This delegate method will be called second. This method will give information about what operation exactly started taking place a insert, a update, a delete or a move. The enum NSFetchedResultsChangeType will provide the change types.
   
   
   public enum NSFetchedResultsChangeType : UInt {
   
   case insert
   
   case delete
   
   case move
   
   case update
   }
   
   */
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    print("B. NSFetchResultController didChange NSFetchedResultsChangeType \(type.rawValue):)")

    
    switch (type) {
    case .insert:
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break;
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      break;
    case .update:
      if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
        configureCell(cell as! MyTableViewCell, at: indexPath)
      }
      break;
      
    case .move:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      
      if let newIndexPath = newIndexPath {
        tableView.insertRows(at: [newIndexPath], with: .fade)
      }
      break;
      
    @unknown default:
        fatalError()
    }
}
  
  /*The last delegate call*/
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    /*finally balance beginUpdates with endupdates*/
    tableView.endUpdates()
  }
}
