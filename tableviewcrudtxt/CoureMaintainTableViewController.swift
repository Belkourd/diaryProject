//
//  CoureMaintainTableViewController.swift
//  tableviewcrudtxt
//
//  Created by Kinki Lai on 2017/3/17.
//  Copyright © 2017年 Kinki Lai. All rights reserved.
//

import UIKit

class CoureMaintainTableViewController: UITableViewController {
    var coureSelect:[String:String]!
    var datePicker : UIDatePicker!
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem){
        let  notificationName = Notification.Name("maintainNotification")
        saveDate()
        NotificationCenter.default.post(
            name: notificationName, object: nil, userInfo: coureSelect)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    func saveDate()
    {
        coureSelect = ["name":nameTextField.text!,
                       "startdate":startdateTextField.text!,
                       "enddate":enddateTextField.text!,"pic":"1",
                       "description":descriptionTextView.text!,
                       "weblink":weblinkTextField.text!]
        
    }
    
    
    
    @IBOutlet weak var enddateTextField: UITextField!
    @IBOutlet weak var startdateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weblinkTextField: UITextField!

    @IBOutlet var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
   super.viewDidLoad()
        tableView.backgroundColor = UIColor(patternImage: UIImage(named:"background.png")!)
        
        if coureSelect != nil {
            showData()
        }
     //print(coureSelect)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func chooseDateAction(_ sender: UITextField) {
       self.pickUpDate(sender)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showData()
    {
        nameTextField.text=coureSelect["name"]
        startdateTextField.text=coureSelect["startdate"]
        enddateTextField.text=coureSelect["enddate"]
        weblinkTextField.text=coureSelect["weblink"]
        descriptionTextView.text=coureSelect["description"]
        
        
    }
    func pickUpDate(_ textField : UITextField){
        // DatePicker
        
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.datePickerMode = UIDatePickerMode.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if textField.tag==1
        {
            if let text = startdateTextField.text, !text.isEmpty
            {
                datePicker.date=dateFormatter.date(from:startdateTextField.text!)!
                
            }
            
        }
        else
        {
            if let text = enddateTextField.text, !text.isEmpty
            {
                datePicker.date=dateFormatter.date(from:enddateTextField.text!)!
                
            }
        }
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CoureMaintainTableViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    func doneClick(_ textField : UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if startdateTextField.isFirstResponder{
            startdateTextField.text = dateFormatter.string(from: datePicker.date)
            startdateTextField.resignFirstResponder()
        }else{
            enddateTextField.text = dateFormatter.string(from: datePicker.date)
            enddateTextField.resignFirstResponder()
        }
        
    }
    func cancelClick() {
        if startdateTextField.isFirstResponder{
            
            startdateTextField.resignFirstResponder()
        }else{
            
            enddateTextField.resignFirstResponder()
        }
    }    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
