//
//  HomeVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 13/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    // MARK: - Variables
    var helper:CoreDataHelper!
    var sessionList = [Session]()
    var createdSessionName = String()
    var createdSessionID = Int()
    var existedSessionID = Int()
    
    
    // MARK: - IBOutlet Function
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        setStatusBar(backgroundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1))
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), backgoundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), tintColor: .white, title: "Home", preferredLargeTitle: true)
        //roundedNavigationBar(title: "Home")
        tabBarCustomization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        helper = CoreDataHelper(context: getViewContext())
    }
    
    
    // MARK: - IBAction Function
    @IBAction func createSessionButtonAction(_ sender: Any) {
        let userFirstName = userFullName?.split(separator: " ")
        createdSessionName = String(userFirstName?[0] ?? "")
        createdSessionID = currentUserID ?? 0
        Session.createSession(createdSessionID, createdSessionName)
        User.addSessionToMember(createdSessionID, currentUserID ?? 0)
        sessionList = helper.fetchAll()
        print(sessionList)
        
        print("\n\nCurrentUserID = \(String(describing: currentUserID))\n\nUserEmail = \(String(describing: userEmail))\n\nUserFullName = \(String(describing: userFullName))\n\n")
        
        self.performSegue(withIdentifier: "CreateSessionSegue", sender: nil)
    }
    
    @IBAction func joinSessionButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Join Session", message: "Please enter Session ID.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input Session ID here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            var existedSession = [Session]()
            if let sessionID = alert.textFields?.first?.text {
                print("Session ID: \(sessionID)")
                self.existedSessionID = Int(sessionID) ?? 0
                existedSession = self.helper.fetchSpecificID(idType: "sessionID", id: self.existedSessionID)
            }
            if !existedSession.isEmpty {
                User.addSessionToMember(self.existedSessionID, currentUserID!)
                let joinedUserList = self.helper.fetchSpecificID(idType: "userID", id: currentUserID!) as [User]
                print(joinedUserList)
                self.performSegue(withIdentifier: "JoinSessionSegue", sender: nil)
            }else{
                self.existedSessionID = 0
                //tolong kasih komponen apakek disini yg bisa ngasih tau user kalo sessionID yg di cari ga exist
                let alert = UIAlertController(title: "Session ID Doesn't Exist", message: "Make sure you input the right Session ID.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Function
    func tabBarCustomization() {
        if isDarkMode {
            tabBarController?.tabBar.backgroundImage = UIImage.colorForNavBar(color: #colorLiteral(red: 0.9733727574, green: 0.9684185386, blue: 0.9727495313, alpha: 1))
            tabBarController?.tabBar.shadowImage = UIImage.colorForNavBar(color: #colorLiteral(red: 0.6979846954, green: 0.6980700493, blue: 0.6979557276, alpha: 1))
            tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0.9781295657, green: 0.9682558179, blue: 0.9726726413, alpha: 1)
            tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1)
            tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        }
        else {
            tabBarController?.tabBar.backgroundImage = UIImage.colorForNavBar(color: #colorLiteral(red: 0.9780731797, green: 0.968344748, blue: 0.9683598876, alpha: 1))
            tabBarController?.tabBar.shadowImage = UIImage.colorForNavBar(color: #colorLiteral(red: 0.6979846954, green: 0.6980700493, blue: 0.6979557276, alpha: 1))
            tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0.9781295657, green: 0.9682558179, blue: 0.9726726413, alpha: 1)
            tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1)
            tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        }
        
        // Rounded Tab Bar
        /*
         let offset : CGFloat = (tabBarController?.view.safeAreaInsets.bottom ?? 20)
         
         let shadowView = UIView(frame: CGRect(x: 0, y: 0,
         width: (tabBarController?.tabBar.bounds.width)!,
         height: (tabBarController?.tabBar.bounds.height)! + offset))
         shadowView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
         tabBarController?.tabBar.insertSubview(shadowView, at: 1)
         
         let shadowLayer = CAShapeLayer()
         shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
         
         shadowLayer.fillColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
         
         shadowLayer.shadowColor = UIColor.darkGray.cgColor
         shadowLayer.shadowPath = shadowLayer.path
         shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
         shadowLayer.shadowOpacity = 0.2
         shadowLayer.shadowRadius = 4
         
         shadowView.layer.insertSublayer(shadowLayer, at: 0)
         */
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //cek segue yang mana
        if segue.identifier == "CreateSessionSegue"{
            //kirim data
            
            //tanya ke segue tujuannya kemana, di cek tujuannya bener ato engga itu view yang mau di tuju
            if let  destination = segue.destination as? SessionHostVC{
                destination.sessionName = self.createdSessionName
                destination.sessionID = self.createdSessionID
            }
        }
        
        else if segue.identifier == "JoinSessionSegue"{
            //kirim data
            
            //tanya ke segue tujuannya kemana, di cek tujuannya bener ato engga itu view yang mau di tuju
            if let  destination = segue.destination as? SessionMemberVC{
//                destination.sessionName = self.createdSessionName
                destination.sessionID = self.existedSessionID
            }
        }
        
    }
    
}
