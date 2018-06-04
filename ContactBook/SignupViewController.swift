//
//  SignupViewController.swift
//  ContactBook
//
//  Created by 紀緯明 on 2018/5/28.
//  Copyright © 2018年 ConactBook. All rights reserved.
//

import UIKit
import CoreData

class SignupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //display DB
    var aryContactBook = [NSManagedObject]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryContactBook.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = aryContactBook[indexPath.row].value(forKey: "account") as? String
        return cell
        
    }
    
    @IBOutlet weak var teacherSwitch: UISwitch!
    @IBOutlet weak var parentsSwitch: UISwitch!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var doublecheckTextField: UITextField!
    @IBOutlet weak var tvContactBook: UITableView!
    
    func getAndShowData(){
        //把資料讀入aryContactBook陣列中
        //建立
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //進行資料要求
        let contactbookRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //讀資料
        do{
            let result = try context.fetch(contactbookRequest)
            aryContactBook = result as! [NSManagedObject]
        }catch{
            print("讀取資料庫過程錯誤")
        }
        tvContactBook.reloadData()
    }

    @IBAction func signupButton(_ sender: UIButton) {
        //建立
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //確定
        let userEntity = NSEntityDescription.entity(forEntityName:"User", in: context)
        //新增一筆
        let newUser = NSManagedObject(entity: userEntity!,insertInto: context)
        //把要存得值填入架構中
        newUser.setValue(accountTextField.text, forKey:"account")
        newUser.setValue(passwordTextField.text, forKey:"password")
        newUser.setValue(parentsSwitch.isOn, forKey:"userstatus")
        //存擋
        do{
            try context.save()
            print("ok")
        }catch{
            print("註冊過程有誤")
        }
        getAndShowData()
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tvContactBook.dataSource = self
//        tvContactBook.delegate = self
//        getAndShowData()
//        // Do any additional setup after loading the view.
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
