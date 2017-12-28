//
//  RMIClient.h
//  RMI
//
//  Created by Alex Vihlayew on 12/27/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMIClientConnection.h"
#import "RMIConnectionDelegate.h"
#import "RMIInvocationRequest.h"
#include "RMIRequestResponceMapper.h"

@interface RMIClient : NSObject <RMIConnectionDelegate>

#pragma mark Initialization

/*!
 * @discussion Default RMIServer initializer.
 * @return An initialized RMIServer object.
 */
- (instancetype)initWithHost:(NSString*)host port:(NSInteger)port;

- (void)connect;

- (void)disconnect;

- (void)writeString:(char*)data;

#pragma mark Method invocation

- (void)invokeMethod:(NSString*)methodName ofTarget:(RMIInvocationTargetType)targetType withName:(NSString*)targetName withParametersDictionary:(NSDictionary*)parametersDictionary;

@end
