//
//  ProfileTableVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 11/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class ProfileTableVC: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Variables
    let notificationCenter = NotificationCenter.default
    
    var editMode = false
    
    let sessionIDLabelPlaceholderText = "123456789"
    let nameTextViewPlaceholderText = "Your Name"
    let emailTextViewPlaceholderText = "youremail@email.com"
    
    
    // MARK: - Arrays
    let badgeImage = ["Bronze I",
                      "Bronze II",
                      "Bronze III",
                      "Silver I",
                      "Silver II",
                      "Silver III",
                      "Gold I",
                      "Gold II",
                      "Gold III"]
    let rankLabel = ["Bronze I",
                     "Bronze II",
                     "Bronze III",
                     "Silver I",
                     "Silver II",
                     "Silver III",
                     "Gold I",
                     "Gold II",
                     "Gold III"]
    let rankLabelColor = [(UIColor.rbg(r: 241, g: 144, b: 73)), //Bronze
                          (UIColor.rbg(r: 241, g: 144, b: 73)), //Bronze
                          (UIColor.rbg(r: 241, g: 144, b: 73)), //Bronze
                          (UIColor.rbg(r: 160, g: 168, b: 184)), //Silver
                          (UIColor.rbg(r: 160, g: 168, b: 184)), //Silver
                          (UIColor.rbg(r: 160, g: 168, b: 184)), //Silver
                          (UIColor.rbg(r: 255, g: 177, b: 15)), //Gold
                          (UIColor.rbg(r: 255, g: 177, b: 15)), //Gold
                          (UIColor.rbg(r: 255, g: 177, b: 15))] //Gold
    let xpLabel = ["0 XP",
                   "50 XP",
                   "100 XP",
                   "200 XP",
                   "300 XP",
                   "400 XP",
                   "600 XP",
                   "800 XP",
                   "1000 XP"]
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var largeBadgeImage: UIImageView!
    @IBOutlet weak var largeRankLabel: UILabel!
    @IBOutlet weak var largeXPLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var sessionIDLabel: UILabel!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var emailTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.keyboardDismissMode = .onDrag
        
        loadProfileData()
        loadTextView()
        
        //buat update badge ke cloud
//        User.setBadgeToMember(userID: currentUserID, badgeTitle: currentBadgeTitle, badgePicture: currentBadgePicture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.backgroundColor = #colorLiteral(red: 0.9750029445, green: 0.9783667922, blue: 0.9844790101, alpha: 1)
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), backgoundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), tintColor: .white, title: "Profile", preferredLargeTitle: true)
        //roundedNavigationBar(title: "Profile")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        nameTextView.centerVertically()
        emailTextView.centerVertically()
    }
    
    
    // MARK: - IBAction Function
    @IBAction func editButtonAction(_ sender: Any) {
        if editMode == false {
            editButtonOutlet.setTitle("Done", for: .normal)
            editMode = true
            
            nameTextView.isEditable = true
            emailTextView.isEditable = false
            
            nameTextView.textColor = .darkText
            emailTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
        }
        else {
            editButtonOutlet.setTitle("Edit", for: .normal)
            editMode = false
            
            nameTextView.isEditable = false
            emailTextView.isEditable = false
            
            nameTextView.isSelectable = false
            emailTextView.isSelectable = false
            
            nameTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
            emailTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
            
            nameTextView.resignFirstResponder()
        }
    }
    
    
    // MARK: - Function
    func loadProfileData() {
        if currentXP ?? 0 >= 0 && currentXP ?? 0 < 200 {
            largeBadgeImage.image = UIImage(named: "Bronze I")
            largeRankLabel.text = "Bronze I"
            largeRankLabel.textColor = #colorLiteral(red: 0.9450980392, green: 0.5647058824, blue: 0.2862745098, alpha: 1)
            titleLabel.text = "Awaro Beginner"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Bronze I", badgePicture: "Bronze I", achievedTitle: "Awaro Beginner")
        }
        else if currentXP ?? 0 >= 200 && currentXP ?? 0 < 300 {
            largeBadgeImage.image = UIImage(named: "Bronze II")
            largeRankLabel.text = "Bronze II"
            largeRankLabel.textColor = #colorLiteral(red: 0.9450980392, green: 0.5647058824, blue: 0.2862745098, alpha: 1)
            titleLabel.text = "A New Beginning"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Bronze II", badgePicture: "Bronze II", achievedTitle: "A New Beginning")
        }
        else if currentXP ?? 0 >= 300 && currentXP ?? 0 < 400 {
            largeBadgeImage.image = UIImage(named: "Bronze III")
            largeRankLabel.text = "Bronze III"
            largeRankLabel.textColor = #colorLiteral(red: 0.9450980392, green: 0.5647058824, blue: 0.2862745098, alpha: 1)
            titleLabel.text = "On The Way Up"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Bronze III", badgePicture: "Bronze III", achievedTitle: "On The Way Up")
        }
        else if currentXP ?? 0 >= 400 &&  currentXP ?? 0 < 500{
            largeBadgeImage.image = UIImage(named: "Silver I")
            largeRankLabel.text = "Silver I"
            largeRankLabel.textColor = #colorLiteral(red: 0.6274509804, green: 0.6588235294, blue: 0.7215686275, alpha: 1)
            titleLabel.text = "Who's Outside The Class?"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Silver I", badgePicture: "Silver I", achievedTitle: "Who's Outside The Class?")
        }
        else if currentXP ?? 0 >= 500 && currentXP ?? 0 < 600{
            largeBadgeImage.image = UIImage(named: "Silver II")
            largeRankLabel.text = "Silver II"
            largeRankLabel.textColor = #colorLiteral(red: 0.6274509804, green: 0.6588235294, blue: 0.7215686275, alpha: 1)
            titleLabel.text = "Who's Inside The Class?"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Silver II", badgePicture: "Silver II", achievedTitle: "Who's Inside The Class?")
        }
        else if currentXP ?? 0 >= 600 && currentXP ?? 0 < 700{
            largeBadgeImage.image = UIImage(named: "Silver III")
            largeRankLabel.text = "Silver III"
            largeRankLabel.textColor = #colorLiteral(red: 0.6274509804, green: 0.6588235294, blue: 0.7215686275, alpha: 1)
            titleLabel.text = "Class Master"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Silver III", badgePicture: "Silver III", achievedTitle: "Class Master")
        }
        else if currentXP ?? 0 >= 700 && currentXP ?? 0 < 800{
            largeBadgeImage.image = UIImage(named: "Gold I")
            largeRankLabel.text = "Gold I"
            largeRankLabel.textColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.05882352941, alpha: 1)
            titleLabel.text = "700 and Up"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Gold I", badgePicture: "Gold I", achievedTitle: "700 and Up")
        }
        else if currentXP ?? 0 >= 800 && currentXP ?? 0 < 900{
            largeBadgeImage.image = UIImage(named: "Gold II")
            largeRankLabel.text = "Gold II"
            largeRankLabel.textColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.05882352941, alpha: 1)
            titleLabel.text = "One in A Million"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Gold II", badgePicture: "Gold II", achievedTitle: "One in A Million")
        }
        else if currentXP ?? 0 >= 900 {
            largeBadgeImage.image = UIImage(named: "Gold III")
            largeRankLabel.text = "Gold III"
            largeRankLabel.textColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.05882352941, alpha: 1)
            titleLabel.text = "The Chosen One"
            User.setBadgeToMember(userID: currentUserID ?? 0, badgeTitle: "Gold III", badgePicture: "Gold III", achievedTitle: "The Chosen One")
        }
        
//        largeBadgeImage.image = UIImage(named: currentBadgePicture ?? "")
//        largeRankLabel.text = currentBadgeTitle
        largeXPLabel.text = "\(currentXP ?? 0) XP"
//        titleLabel.text = currentAchievedTitle
        
        if currentUserID == nil {
            sessionIDLabel.text = sessionIDLabelPlaceholderText
        }
        else {
            sessionIDLabel.text = "\(currentUserID ?? 0)"
        }
    }
    
    
    // MARK: - Table view data source

    // Uncomment to use Dynamic Prototypes
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        else if section == 2 {
            return 1
        }
        else {
            return 2
        }
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCollectionCell", for: indexPath) as! BadgeCollectionCell
        let floatXP = Float(currentXP ?? 0)
    
        // Configure the cell
        cell.xpProgressView.setProgress(floatXP / 1000, animated: true)
        print(floatXP / 1000)
        
        if currentXP ?? 0 >= 0 {
            cell.bronze1DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 200 {
            cell.bronze2DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 300 {
            cell.bronze3DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 400 {
            cell.silver1DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 500 {
            cell.silver2DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 600 {
            cell.silver3DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 700 {
           cell.gold1DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 800 {
            cell.gold2DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        if currentXP ?? 0 >= 900 {
            cell.gold3DotView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 125)
    }
     */

}


// MARK: - UITextViewDelegate
extension ProfileTableVC: UITextViewDelegate {
    
    func loadTextView() {
        nameTextView.delegate = self
        emailTextView.delegate = self
        
        nameTextView.tag = 0
        emailTextView.tag = 1
        
        if userFullName == nil && userEmail == nil {
            nameTextView.text = nameTextViewPlaceholderText
            emailTextView.text = emailTextViewPlaceholderText
        }
        else {
            nameTextView.text = userFullName
            emailTextView.text = userEmail
        }
        
        nameTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
        emailTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
        
        nameTextView.isEditable = false
        emailTextView.isEditable = false
        
        nameTextView.isSelectable = false
        emailTextView.isSelectable = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.tag == 0) {
            nameTextView.textColor = .darkText
        }
        if (textView.tag == 1) {
            emailTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if nameTextView.text.isEmpty {
            if userFullName == nil {
                nameTextView.text = nameTextViewPlaceholderText
            }
            else {
                nameTextView.text = userFullName
            }
            nameTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
        }
        if emailTextView.text.isEmpty {
            if userEmail == nil {
                emailTextView.text = emailTextViewPlaceholderText
            }
            else {
                emailTextView.text = userEmail
            }
            emailTextView.textColor = #colorLiteral(red: 0.3014600277, green: 0.3024867773, blue: 0.332267046, alpha: 0.6)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == nameTextView && text == "\n" {  // Recognizes enter key in keyboard
            nameTextView.resignFirstResponder()
            return false
        }
        return true
    }
}
