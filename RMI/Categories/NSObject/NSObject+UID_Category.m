//
//  NSObject+NSObject_Category.m
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "NSObject+UID_Category.h"

@interface NSObject ()

@property (nonatomic) NSNumber* UID;

@end

static int MAX_UID = 0;
static void *UID_KEY = "UID_KEY";

@implementation NSObject (UID_Category)

- (void)setUID:(NSNumber *)UID {
    objc_setAssociatedObject(self, UID_KEY, UID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLog(@"Did set object UID to: %@", UID);
}

- (NSNumber*)UID {
    return objc_getAssociatedObject(self, UID_KEY);
}

+ (void)swizzleInit {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(init);
        SEL swizzledSelector = @selector(swizzled_init);
        
        Method originalMethod = class_getClassMethod(class, originalSelector);
        Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

+ (instancetype)swizzled_init {
    id instnc = [self swizzled_init];
    MAX_UID++; // FIXME: Cam have troubles with multithreaded execution
    [instnc setUID:[NSNumber numberWithInt:MAX_UID]];
    return instnc;
}

@end
