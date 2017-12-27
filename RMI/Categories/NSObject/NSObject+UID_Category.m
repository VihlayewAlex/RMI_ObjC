//
//  NSObject+NSObject_Category.m
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "NSObject+UID_Category.h"

@interface NSObject ()

/*!
 * @brief An NSObject UID (unique for every NSObject instance).
 */
@property (nonatomic) NSNumber* UID;

@end

static int MAX_UID = 0;
static void *UID_KEY = "UID_KEY";

@implementation NSObject (UID_Category)

/*!
 * @discussion NSObject UID setter.
 */
- (void)setUID:(NSNumber *)UID {
    objc_setAssociatedObject(self, UID_KEY, UID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLog(@"Did set object UID to: %@", UID);
}

/*!
 * @discussion NSObject UID getter.
 */
- (NSNumber*)UID {
    return objc_getAssociatedObject(self, UID_KEY);
}

/*!
 * @discussion A method for init swizzling.
 This swaps the + (instancetype)init with + (instancetype)swizzled_init.
 */
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

/*!
 * @discussion Swizzled innitializer.
 This swaps the + (instancetype)init with + (instancetype)swizzled_init.
 */
+ (instancetype)swizzled_init {
    id instnc = [self swizzled_init];
    MAX_UID++; // FIXME: Cam have troubles with multithreaded execution
    [instnc setUID:[NSNumber numberWithInt:MAX_UID]];
    return instnc;
}

@end
