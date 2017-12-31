//
//  RMIInvocationRequest.h
//  RMI
//
//  Created by Alex Vihlayew on 02/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMIInvocationInfo.h"

@interface RMIInvocationRequest : NSObject

/*!
 * @discussion An ID of the request to map responces to requests
 */
@property (assign, nonatomic) NSInteger ID;

/*!
 * @discussion A string that identifies target method
 */
@property (strong, nonatomic) NSString* methodName;

/*!
 * @discussion A target type (class / object)
 */
@property (assign, nonatomic) RMIInvocationTargetType targetType;

/*!
 * @discussion A name of a target (Class name / instance UID)
 */
@property (strong, nonatomic) NSString* targetName;

/*!
 * @discussion Dictionary of parameters to be passed to the receiver's target method
 */
@property (strong, nonatomic) NSDictionary* parametersDictionary;

@end
