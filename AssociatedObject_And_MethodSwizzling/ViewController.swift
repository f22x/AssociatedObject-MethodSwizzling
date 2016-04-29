//
//  ViewController.swift
//  AssociatedObject_And_MethodSwizzling
//
//  Created by lei on 15/5/20.
//  Copyright (c) 2015年 lei. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let isExtensionController = ExtensionViewController()
        isExtensionController.viewDidLoad()
        
        self.descriptiveName = "change name";
        self.printDescriptName(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController{
    // 创建一个私有结构体
    private struct AssociatedKeys {
        static var DescriptiveName = "DescriptiveName"
    }
    // 创建一个descritionName（String类型）的属性便于外界访问
    var descriptiveName : String? {
        get {
            // 使用objc_getAssociatedObjct方法：包含两个部分，1、self；2、指向结构体成员变量的指针。
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set {
            if let newValue = newValue {
                // 常量的实现基于objc_setAssociatedObject方法：包含4个参数，1、self；2、指向结构体成员变量的指针；3、新值（String类型）；4、关联对象存储类型（retain，nonatomic）
                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue as NSString?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    func printDescriptName(input: UIViewController) {
        if let name = input.descriptiveName {
            print("name: \(name)")
        } else {
            print("没有设置")
        }
    }
}

// MARK: - 交叉互换
extension UIViewController {
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        dispatch_once(&Static.token) {
            let originalSelector = Selector("viewWillAppear:")
            let swizzledSelector = Selector("nsh_viewWillAppear:")
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    }
    
    // MARK: - Method Swizzling
    
    func nsh_viewWillAppear(animated: Bool) {
        self.nsh_viewWillAppear(animated)
        if let name = self.descriptiveName {
            print("viewWillAppear: \(name)")
        } else {
            print("viewWillAppear: \(self)")
        }
    }
}









