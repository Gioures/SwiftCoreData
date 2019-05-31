//
//  SaveCoreData.swift
//  SwiftCoreData
//
//  Created by 段庆烨 on 2019/5/9.
//  Copyright © 2019年 Gioures. All rights reserved.
//

import UIKit


class SaveCoreData: NSObject {
    let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @available(iOS 10.0,*)
    lazy var context = app.persistentContainer.viewContext;
}
