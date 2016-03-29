//
//  ExtensionViewController.swift
//  AssociatedObject_And_MethodSwizzling
//
//  Created by xinglei on 15/5/20.
//  Copyright (c) 2015年 ZPlay. All rights reserved.
//

import UIKit

class ExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptiveName = "123"
        // Do any additional setup after loading the view.
        print("\(self.descriptiveName)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
