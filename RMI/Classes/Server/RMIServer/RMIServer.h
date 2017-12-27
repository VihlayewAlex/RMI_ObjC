//
//  RMIServer.h
//  RMI
//
//  Created by Alex Vihlayew on 22/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMIInvocationInfo.h"
#import "NSObject+UID_Category.h"
#import "RMIConnectionDelegate.h"
#import "RMIServerConnection/RMIServerConnection.h"
#import "RMIConnectionState.h"

@interface RMIServer : NSObject <RMIConnectionDelegate>

#pragma mark Properties

/*!
 * @brief Array of sessions that are managed by this server.
 */
@property (strong, nonatomic) RMIServerConnection* _Nonnull connection;

#pragma mark Initialization

/*!
 * @discussion Default RMIServer initializer.
 * @return An initialized RMIServer object.
 */
- (instancetype _Nullable )init;

#pragma mark State control

/*!
 * @discussion Opens default server connection.
 */
- (void)start;

/*!
 * @discussion Closes default server connection.
 */
- (void)stop;

#pragma mark Registering methods

/*!
 * @discussion A method for registering new object and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetObject Object that must respond to a passed selector.
 */
- (void)registerSelector:(SEL _Nonnull)invocationSelector forObject:(NSObject* _Nonnull)targetObject;

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 */
- (void)registerSelector:(SEL _Nonnull)invocationSelector forClass:(Class _Nonnull)targetClass;

@end
