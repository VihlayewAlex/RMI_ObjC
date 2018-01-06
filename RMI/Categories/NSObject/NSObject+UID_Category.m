//
//  NSObject+NSObject_Category.m
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "NSObject+UID_Category.h"

@interface NSObject ()

@end

static void * UUIDPropertyKey = &UUIDPropertyKey;

@implementation NSObject (UID_Category)

/*!
 * @discussion NSObject UID getter.
 */
- (NSString*)UID
{
    NSString* uuid = objc_getAssociatedObject(self, UUIDPropertyKey);
    if (!uuid) {
        NSString *UUID = [[NSUUID UUID] UUIDString];
        objc_setAssociatedObject(self, UUIDPropertyKey, UUID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, UUIDPropertyKey);
}

@end
