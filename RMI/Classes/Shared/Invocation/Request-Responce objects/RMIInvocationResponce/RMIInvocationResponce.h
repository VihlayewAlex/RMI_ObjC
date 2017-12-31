//
//  RMIInvocationResponce.h
//  RMI
//
//  Created by Alex Vihlayew on 02/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMIInvocationResponce : NSObject

/*!
 * @discussion A unique key that identifies receiver and it's target method
 */
@property (assign, nonatomic) NSInteger ID;

/*!
 * @discussion Shows if method invocation was successful or not
 */
@property (assign, nonatomic) BOOL success;

/*!
 * @discussion Dictionary of parameters that was sent back from the receiver as a return value
 */
@property (strong, nonatomic) NSDictionary* responceDictionary;

@end
