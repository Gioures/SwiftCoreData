//
//  ViewController.swift
//  SwiftCoreData
//
//  Created by 段庆烨 on 2019/5/7.
//  Copyright © 2019年 Gioures. All rights reserved.
//

import UIKit
import CoreData




class ViewController: UIViewController {
    //获取管理的数据背景 对象
    let app = UIApplication.shared.delegate as! AppDelegate
    

    

    lazy var context: NSManagedObjectContext = {
        if #available(iOS 10.0,*){
            return app.persistentContainer.viewContext;
        }else{
            return app.managedObjectContext;
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func zeng(_ sender: UIButton) {
        //创建stu对象
        let stu = NSEntityDescription.insertNewObject(forEntityName: "Student",
                                                       into: context) as! Student
        //对象赋值
        stu.id = 1
        stu.name = "张三"
        
        //保存
        do {
            try context.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    
    
    
    @IBAction func shan(_ sender: UIButton) {
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Student>(entityName:"Student")
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "id= '1' ")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            //遍历查询的结果
            for info in fetchedObjects{
                //删除对象
                context.delete(info)
            }
            //重新保存-更新到数据库
            try! context.save()
            print("删除成功！")
        }
        catch {
            fatalError("查询失败：\(error)")
        }
    }
    
    
    
    
    @IBAction func gai(_ sender: UIButton) {
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Student>(entityName:"Student")
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "name= '张三' ")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            //遍历查询的结果
            for info in fetchedObjects{
                //修改密码
                info.name = "李四"
                //重新保存
                try context.save()
                print("修改成功！")
            }
            
        }
        catch {
            fatalError("查询失败：\(error)")
        }
    }
    
    
    
    
    @IBAction func cha(_ sender: UIButton) {
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Student>(entityName:"Student")
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "id= '1' ", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            //遍历查询的结果
            var array = [Any]()
            for info in fetchedObjects{
                print("id=\(info.id)")
                print("name=\(String(describing: info.name))")
                print(info);
                array.append(info);
            }
        }
        catch {
            fatalError("查询失败：\(error)")
        }
    }
}


