//
//  CoursesTableViewController.swift
//  tableviewcrudtxt
//
//  Created by Kinki Lai on 2017/3/17.
//  Copyright © 2017年 Kinki Lai. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    
    @IBOutlet var couresTableView: UITableView!
    var courses = [Dictionary<String,String>]()
    let initcourses = [["name":"海洋大學一日遊",
                        "startdate":"2017/06/18",
                        "enddate":"2017/06/19",
                        "pic":"NTOU",
                        "description":"海大超讚讚讚!",
                        "weblink":"http://www.ntou.edu.tw/bin/home.php"]]
    let fileManager = FileManager.default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        couresTableView.backgroundColor = UIColor(patternImage: UIImage(named:"background.png")!)
        let notificationName = Notification.Name("maintainNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(self.maintainCoureNotification(noti:)), name: notificationName, object: nil)
        let url = Setfile()
        if let readcourses = NSArray(contentsOf: url!)
        {
            courses = readcourses as![Dictionary<String,String>]
        }
        else
        {
            (initcourses as NSArray).write(to: url!, atomically:true)
            courses = initcourses
        }
        
    }
    func Setfile()->URL? {
        let docUrls = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let docUrl = docUrls.first
        
        let url = docUrl?.appendingPathComponent("courses.txt")
        return url
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courselist", for: indexPath) as! CoursesTableViewCell
        
        let dic = courses[indexPath.row]
        cell.name.text=dic["name"]!
        cell.coursedate.text="\(dic["startdate"]!)~\(dic["enddate"]!)"
        //cell.weblink.text="\(dic["weblink"]!)"
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is CoureDetailTableViewController{
            let controller = segue.destination as! CoureDetailTableViewController
            
            let indexPath = self.couresTableView.indexPathForSelectedRow
            let courseSelect = courses[indexPath!.row]
            controller.coureSelect = courseSelect
        }
        
        
    }
    func maintainCoureNotification(noti:Notification) {
        
        if self.couresTableView.indexPathForSelectedRow != nil {
            courses[self.couresTableView.indexPathForSelectedRow!.row] = noti.userInfo as! [String:String]
        }
        else{
            
            self.courses.insert(noti.userInfo as! [String:String], at: 0)
        }
        let url = Setfile()
        (courses as NSArray).write(to: url!, atomically:true)
        self.couresTableView.reloadData()
        
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        courses.remove(at: indexPath.row)
        let url = Setfile()
        (courses as NSArray).write(to: url!, atomically:true)
        tableView.reloadData()
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
