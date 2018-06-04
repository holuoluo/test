//
//  CalendarViewController.swift
//  ContactBook
//
//  Created by holuoluo on 2018/6/1.
//  Copyright © 2018年 ConactBook. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    可是要服從UICollectionViewDatasource跟UICollectionViewDelegate協定的類別才能做CollectionView的這兩個屬性，所以先設定讓ViewController 類別服從這兩個協定。(實作兩個方法)
    
    /*
     把 Calendar View 的 dataSource 跟 delegate 連結到 View Controller。意思是現在 View Controller 就是 Calendar View的 dataSource 跟 delegate 屬性，負責告訴 collection view 要顯示什麼資料。
     */
    
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
//    算法是先把目前的年份跟月份當做參數去產生一個 DateComponents，接著呼叫Calendar類別，不用初始化的屬性current 的 date from 方法。裡面就填入上一步產生的 date components 當作參數。就可以得到一個 Date 類別的實體。把這個得到的結果存進常數 date 裡面。
    
    var numberOfDaysInThisMonth:Int{
        let dateComponents = DateComponents(year: currentYear ,
                                            month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month,
                                           for: date)

//        print("range:", range)
        return range?.count ?? 0
//        如果失敗沒有值就回傳 0
    }
    
    
    
//    得到了一個月的第一天。然後用 Calendar.current 得到目前使用者的日曆實體。呼叫日曆的 component 方法，就可以知道每個月的第一天是星期幾。如果是週日的話，這個數值就是1，如果是週一的話，這個數值就是 2。把這個數值回傳出去。

    var whatDayIsIt:Int{
        let dateComponents = DateComponents(year: currentYear ,
                                            month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    
//  計算每月應空下的空格（數量）
    var howManyItemsShouldIAdd:Int{
        return whatDayIsIt - 1
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        currentMonth += 1
        if currentMonth == 13{
            currentMonth = 1
            currentYear += 1
//        已經到13月了的話，就設定回1月，然後跳下一年
        }
        setUp()
    }
    @IBAction func lastMonth(_ sender: Any) {
        currentMonth -= 1
        if currentMonth == 0{
            currentMonth = 12
            currentYear -= 1
        }
        setUp()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        setUp()
    }
    
//    設定日曆顯示日期
//   currentMonth-1: 例如6(月)-1＝5，所以為months[5]為第六個值，所以是6月
    
    func setUp(){
        timeLabel.text = months[currentMonth - 1] + " \(currentYear)"
        calendar.reloadData()
        print("年：", currentYear)
        print("月：", currentMonth)
        print("日：", whatDayIsIt)
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
//        print("驗證：")
        print("numberOfDaysInThisMonth:", numberOfDaysInThisMonth)
        print("howManyItemsShouldIAdd:", howManyItemsShouldIAdd)
        return numberOfDaysInThisMonth + howManyItemsShouldIAdd
//        return numberOfDaysInThisMonth
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =
//            collectionView.dequeueReusableCell(withReuseIdentifier:
//                "cell", for: indexPath)
//        if let textLabel = cell.contentView.subviews[0] as? UILabel{
//            textLabel.text = "\(indexPath.row + 1)"
//        }
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                               for: indexPath)
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            if indexPath.row < howManyItemsShouldIAdd{
                textLabel.text = ""
            }else{
                textLabel.text =
                "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
            }
        }
        return cell
    }
    
    
    
//    第一個方法在設定每個 cell 左右的間隔就會變成0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    第二個方法設定每個 cell 上下的間隔也會變成 0。
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
//    每個 item 的寬度，都想要橫列都只顯示七個 cell，所以寬度就設成 Collection View 的 frame 的寬度除 7。
//    以這樣寬度、高度固定 40 這樣的大小當作每個 cell 的 大小。
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 40)
    }
    
//    打橫看版面也會正常
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendar.collectionViewLayout.invalidateLayout()
        calendar.reloadData()
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
