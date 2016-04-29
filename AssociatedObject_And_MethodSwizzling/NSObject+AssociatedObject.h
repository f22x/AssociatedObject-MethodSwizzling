//
//  ViewController.swift
//  AssociatedObject_And_MethodSwizzling
//
//  Created by lei on 15/5/20.
//  Copyright (c) 2015年 lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)
@property (nonatomic, strong, readwrite)  id associatedObject;

@end
