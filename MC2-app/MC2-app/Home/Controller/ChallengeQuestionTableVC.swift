//
//  ChallengeQuestionTableVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 18/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class ChallengeQuestionTableVC: UITableViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var submitButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var aAnswerTextView: UITextView!
    @IBOutlet weak var bAnswerTextView: UITextView!
    @IBOutlet weak var cAnswerTextView: UITextView!
    @IBOutlet weak var dAnswerTextView: UITextView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationPicker: UIPickerView!
    
    
    // MARK: - Variable
    var minutes: Int = 0
    var seconds: Int = 0
    let questionTextViewPlaceholderText = "Enter your question..."
    let rightAnswerTextViewPlaceholderText = "Your right answer..."
    let wrongAnswerTextViewPlaceholderText = "Your wrong asnwer..."
    var question = ""
    var answerA = ""
    var answerB = ""
    var answerC = ""
    var answerD = ""
    var duration = 0
    var sessionID = Int()
    
    
    // MARK: - View Behaviour
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.keyboardDismissMode = .interactive
        setupTextView()
        setupDurationPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        //isModalInPresentation =  true
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), backgoundColor: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1), tintColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), title: "Challenge Question", preferredLargeTitle: false)
        //roundedNavigationBar(title: "History")
    }
    
    override func viewDidLayoutSubviews() {
        questionTextView.centerVertically()
        aAnswerTextView.centerVertically()
        bAnswerTextView.centerVertically()
        cAnswerTextView.centerVertically()
        dAnswerTextView.centerVertically()
    }
    
    
    // MARK: - IBAction Function
    @IBAction func cancelButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to cancel?", message: "Unsubmitted question won't be saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        question = questionTextView.text
        answerA = aAnswerTextView.text
        answerB = bAnswerTextView.text
        answerC = cAnswerTextView.text
        answerD = dAnswerTextView.text
        currentChallengeCounter += 1
        
        print("\n\n\(question)\n\n\(answerA)\n\n\(answerB)\n\n\(answerC)\n\n\(answerD)\n\nsession id = \(sessionID)\n\nDuration = \(duration)")
        Session.setChallenge(sessionID: sessionID, question: question, answerA: answerA, answerB: answerB, answerC: answerC, answerD: answerD, duration: duration, challengeCounter: currentChallengeCounter)
        performSegue(withIdentifier: "SubmitSegue", sender: nil)
    }
    
    // MARK: - Function
    
    

    // MARK: - Table view data source

    // Uncomment to use Dynamic Prototypes
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
     */
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if isDarkMode ==  true {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            (view as! UITableViewHeaderFooterView).textLabel?.textColor = .black
        }
        else {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            (view as! UITableViewHeaderFooterView).textLabel?.textColor = .black
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 && indexPath.section == 2 {
            let height:CGFloat = durationPicker.isHidden ? 0.0 : 216.0
            
            return height
        }

        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let durationIndexPath = IndexPath(row: 0, section: 2)
        
        if durationIndexPath == indexPath {
            if durationPicker.isHidden == true {
                durationPicker.isHidden = false

                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    // apple bug fix - some TV lines hide after animation
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
            else {
                durationPicker.isHidden = true
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    // apple bug fix - some TV lines hide after animation
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SubmitSegue" {
            //kirim data
            
            //tanya ke segue tujuannya kemana, di cek tujuannya bener ato engga itu view yang mau di tuju
            if let destination = segue.destination as? ChallengeResultVC {
                destination.question = self.question
                destination.answerA = self.answerA
                destination.duration = self.duration
                destination.sessionID = self.sessionID
            }
        }
    }
    

}


// MARK: - UITextViewDelegate
extension ChallengeQuestionTableVC: UITextViewDelegate {
    
    func setupTextView() {
        questionTextView.delegate = self
        aAnswerTextView.delegate = self
        bAnswerTextView.delegate = self
        cAnswerTextView.delegate = self
        dAnswerTextView.delegate = self
        
        questionTextView.tag = 0
        aAnswerTextView.tag = 1
        bAnswerTextView.tag = 2
        cAnswerTextView.tag = 3
        dAnswerTextView.tag = 4
        
        questionTextView.text = questionTextViewPlaceholderText
        aAnswerTextView.text = rightAnswerTextViewPlaceholderText
        bAnswerTextView.text = wrongAnswerTextViewPlaceholderText
        cAnswerTextView.text = wrongAnswerTextViewPlaceholderText
        dAnswerTextView.text = wrongAnswerTextViewPlaceholderText
        
        questionTextView.textColor = .lightGray
        aAnswerTextView.textColor = .lightGray
        bAnswerTextView.textColor = .lightGray
        cAnswerTextView.textColor = .lightGray
        dAnswerTextView.textColor = .lightGray
        
        questionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        aAnswerTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        bAnswerTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        cAnswerTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        dAnswerTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.tag == 0) {
            if questionTextView.text == questionTextViewPlaceholderText {
                questionTextView.text = nil
                questionTextView.textColor = .white
            }
            else {
                questionTextView.textColor = .white
            }
        }
        if (textView.tag == 1) {
            if aAnswerTextView.text == rightAnswerTextViewPlaceholderText {
                aAnswerTextView.text = nil
                aAnswerTextView.textColor = .black
            }
            else {
                aAnswerTextView.textColor = .black
            }
        }
        if (textView.tag == 2) {
            if bAnswerTextView.text == wrongAnswerTextViewPlaceholderText {
                bAnswerTextView.text = nil
                bAnswerTextView.textColor = .black
            }
            else {
                bAnswerTextView.textColor = .black
            }
        }
        if (textView.tag == 3) {
            if cAnswerTextView.text == wrongAnswerTextViewPlaceholderText {
                cAnswerTextView.text = nil
                cAnswerTextView.textColor = .black
            }
            else {
                cAnswerTextView.textColor = .black
            }
        }
        if (textView.tag == 4) {
            if dAnswerTextView.text == wrongAnswerTextViewPlaceholderText {
                dAnswerTextView.text = nil
                dAnswerTextView.textColor = .black
            }
            else {
                dAnswerTextView.textColor = .black
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if questionTextView.text.isEmpty {
            questionTextView.text = questionTextViewPlaceholderText
            questionTextView.textColor = .lightGray
        }
        if aAnswerTextView.text.isEmpty {
            aAnswerTextView.text = rightAnswerTextViewPlaceholderText
            aAnswerTextView.textColor = .lightGray
        }
        if bAnswerTextView.text.isEmpty {
            bAnswerTextView.text = wrongAnswerTextViewPlaceholderText
            bAnswerTextView.textColor = .lightGray
        }
        if cAnswerTextView.text.isEmpty {
            cAnswerTextView.text = wrongAnswerTextViewPlaceholderText
            cAnswerTextView.textColor = .lightGray
        }
        if dAnswerTextView.text.isEmpty {
            dAnswerTextView.text = wrongAnswerTextViewPlaceholderText
            dAnswerTextView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == questionTextView && text == "\n" {  // Recognizes enter key in keyboard
            aAnswerTextView.becomeFirstResponder()
            return false
        }
        if textView == aAnswerTextView && text == "\n" {
            bAnswerTextView.becomeFirstResponder()
            return false
        }
        if textView == bAnswerTextView && text == "\n" {
            cAnswerTextView.becomeFirstResponder()
            return false
        }
        if textView == cAnswerTextView && text == "\n" {
            dAnswerTextView.becomeFirstResponder()
            return false
        }
        if textView == dAnswerTextView && text == "\n" {
            dAnswerTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == questionTextView {
            setSubmitButtonState()
        }
        if textView == aAnswerTextView {
            setSubmitButtonState()
        }
        if textView == bAnswerTextView {
            setSubmitButtonState()
        }
        if textView == cAnswerTextView {
            setSubmitButtonState()
        }
        if textView == dAnswerTextView {
            setSubmitButtonState()
        }
    }
    
    func setSubmitButtonState() {
        if questionTextView.text != questionTextViewPlaceholderText &&
            aAnswerTextView.text != rightAnswerTextViewPlaceholderText &&
            bAnswerTextView.text != wrongAnswerTextViewPlaceholderText &&
            cAnswerTextView.text != wrongAnswerTextViewPlaceholderText &&
            dAnswerTextView.text != wrongAnswerTextViewPlaceholderText &&
            !questionTextView.text.isEmpty &&
            !aAnswerTextView.text.isEmpty &&
            !bAnswerTextView.text.isEmpty &&
            !cAnswerTextView.text.isEmpty &&
            !dAnswerTextView.text.isEmpty {
                submitButtonOutlet.isEnabled = true
        }
        else {
            submitButtonOutlet.isEnabled = false
        }
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
}

// MARK: - UIPickerViewDelegate & DataSource
extension ChallengeQuestionTableVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupDurationPicker() {
        durationPicker.dataSource = self
        durationPicker.delegate = self
        durationPicker.isHidden = true
        
        timeLabel.text = "\(minutes) min" + " " + "\(seconds) sec"
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 2
        case 1:
            return 60
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) min"
        case 1:
            return "\(row) sec"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            minutes = row
            timeLabel.text = "\(minutes) min" + " " + "\(seconds) sec"
        case 1:
            seconds = row
            timeLabel.text = "\(minutes) min" + " " + "\(seconds) sec"
        default:
            break;
        }
        duration = minutes * 60 + seconds
        print("\n\nduration = \(duration)\n\n")
    }
}
