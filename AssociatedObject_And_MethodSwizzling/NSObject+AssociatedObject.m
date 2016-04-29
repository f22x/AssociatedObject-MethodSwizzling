//
//  NSObject+AssociatedObject.m
//  AssociatedObject_And_MethodSwizzling
//
//  Created by lei on 16/3/29.
//  Copyright © 2016年 ZPlay. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+AssociatedObject.h"

static char kAssociatedObjectKey;

@implementation NSObject (AssociatedObject)

@dynamic associatedObject;

- (void)setAssociatedObject:(id)associatedObject {
    objc_setAssociatedObject(self, &kAssociatedObjectKey, associatedObject, OBJC_ASSOCIATION_RETAIN);
}

- (id)associatedObject {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey);
}

@end
