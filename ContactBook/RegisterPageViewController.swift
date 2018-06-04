//
//  RegisterPageViewController.swift
//  ContactBook
//
//  Created by 紀緯明 on 2018/5/24.
//  Copyright © 2018年 ConactBook. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var UserAccount: UITextField!
    @IBOutlet weak var Userpassword: UITextField!
    @IBOutlet weak var RepeatPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        
//        let user = UserAccount.text;
//        let userpassword = Userpassword.text;
//        let repeatpassword = RepeatPassword.text;
        
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
