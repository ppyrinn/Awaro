//
//  HomeVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 13/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundedTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), backgoundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), tintColor: .white, title: "Home", preferredLargeTitle: true)
        //roundedNavigationBar(title: "Home")
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        setStatusBar(backgroundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1))
    }
    
    
    // MARK: - IBAction Function
    @IBAction func createSessionButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func joinSessionButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Join Session", message: "Please enter session ID!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input session ID here..."
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let sessionID = alert.textFields?.first?.text {
                print("Session ID: \(sessionID)")
            }
        }))

        self.present(alert, animated: true)
    }
    
    
    // MARK: - Function
    func roundedTabBar() {
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1)
        tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
