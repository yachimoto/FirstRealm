//
//  ViewController.swift
//  FirstRealm
//
//  Created by SeitoYachimoto on 2019/07/30.
//  Copyright © 2019 谷地元　星斗. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    var items:[Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

//        RealmからItemを全権取得する
        let realm = try! Realm()
        items = realm.objects(Item.self).reversed()
        
        tableView.dataSource = self
        tableView.delegate = self
    }


    @IBAction func addItem(_ sender: UIButton) {
        

//        新しいItemクラス(instance)を作成
        let item = Item()
//        Itemクラスに入力されたタイトルを設定
        item.title = textField.text
//        Realmに保存する
        let realm = try! Realm()
        try! realm.write {
            realm.add(item)
        }
       
//        最新のItem一覧を取得
        items = realm.objects(Item.self).reversed()
//        テーブルを更新
        tableView.reloadData()
//        テキストフィールドをからにする
        textField.text = ""

        
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
//    表示するItemクラスを取得
    let item = items[indexPath.row]
    
//    セルのラベルに、Itemクラスのタイトルを設定です。
    cell.textLabel?.text = item.title
    
    return cell
  }
}
