//
//  NSObject+AssociatedObject.h
//  AssociatedObject_And_MethodSwizzling
//
//  Created by lei on 16/3/29.
//  Copyright © 2016年 ZPlay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)
@property (nonatomic, strong, readwrite)  id associatedObject;

@end
