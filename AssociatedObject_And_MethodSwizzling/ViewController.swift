//
//  ViewController.swift
//  AssociatedObject_And_MethodSwizzling
//
//  Created by xinglei on 15/5/20.
//  Copyright (c) 2015年 ZPlay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let isExtensionController = ExtensionViewController()
        isExtensionController.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//-----------------------------------------------------
//|                                                   |
//|                      关联对象                      *
//|                                                   |
///----------------------------------------------------

extension UIViewController{

//    创建一个私有结构体
    private struct AssociatedKeys{
        
//        静态成员变量DescriptionName
        static var DescriptiveName = "DescriptiveName"
    }

//    创建一个descritionName（String类型）的属性便于外界访问
var descriptiveName : String? {

//    get方法
    get {
//            使用objc_getAssociatedObjct方法：包含两个部分，1、self；2、指向结构体成员变量的指针。
//            返回String类型
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
    
    set {
        
//        set方法
//        创建一个newValue的常量
        if let newValue = newValue{
//            常量的实现基于objc_setAssociatedObject方法：包含4个参数，1、self；2、指向结构体成员变量的指针；3、新值（String类型）；4、关联对象存储类型（retain，nonatomic）
            objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue as NSString?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }

}

/**------------------------------------------------------*
*                                                        |
*   》》》》》》》》》》交叉互换                              *
*                                                        |
*///-----------------------------------------------------*

//extension UIViewController
//{
////    向外提供公共类
//    public override class func initialize() {
//    
//        struct isStatic{
//            
//            static var token : dispatch_once_t = 0
//        }
//    }
//    
//   @objc private func viewDidLoad () {
//    
//    }
////    执行互换
////        dispatch_once(&isStatic.token) {
////            创建对应方法名
//            let originalSelector = Selector("viewDidLoad")
//            let swizzledSelector = Selector("nsh_viewWillAppear:")
////            创建方法
//            let originalMethod = class_getInstanceMethod(self, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
////            添加方法
//            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
////            互换
//            if (didAddMethod) {
//            //    代替
//                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            } else {
//            //    或者交换
//                method_exchangeImplementations(originalMethod, swizzledMethod);
//            }
////        }
//    
////    执行互换后的函数
//    func x_viewWillApear(animated:Bool){
//    
//        self.x_viewWillApear(animated)
//        
//        if let name  = self.descriptiveName{
//            
//            println("viewWillApear: \(name)")
//            
//        }else{
//        
//            println("viewWillAppear: \(self)")
//        }
//    }
//    
//}









