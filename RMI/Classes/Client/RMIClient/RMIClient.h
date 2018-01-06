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
#import "RMIRequestResponceMapper.h"
#import "RMIClientDelegate.h"

@interface RMIClient : NSObject <RMIConnectionDelegate>

@property (weak, nonatomic, nullable) id<RMIClientDelegate> delegate;

#pragma mark Initialization

/*!
 * @discussion Default RMIServer initializer.
 * @return An initialized RMIServer object.
 */
- (instancetype _Nonnull )initWithHost:(NSString* _Nonnull)host port:(NSInteger)port;

/*!
 * @discussion Starts connection to the server.
 */
- (void)connect;

/*!
 * @discussion Stops connection to the server.
 */
- (void)disconnect;

/*!
 * @discussion Sends data to server.
 */
- (void)writeString:(const char* _Nullable)data;

#pragma mark Method invocation

/*!
 * @discussion Invokes remote class / object method on the connected server
 * @param methodName A string representation of remote method selector
 * @param targetType A type of remote message receiver
 * @param targetName A name of a message receiver
 * @param parametersDictionary A discionary of parameters to pass to remote method
 */
- (void)invokeMethod:(NSString*_Nonnull)methodName ofTarget:(RMIInvocationTargetType)targetType withName:(NSString*_Nonnull)targetName withParametersDictionary:(NSDictionary*_Nullable)parametersDictionary withCompletionBlock:(void (^ _Nullable)(RMIInvocationResponce* _Nullable responce))completion;

@end
