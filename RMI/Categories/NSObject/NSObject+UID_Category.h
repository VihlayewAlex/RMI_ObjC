//
//  NSObject+Category.h
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (UID_Category)

/*!
 * @discussion NSObject UID getter.
 */
- (NSString*)UID;

@end

