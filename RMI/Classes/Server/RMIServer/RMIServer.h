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

#pragma mark Initialization

/*!
 * @discussion Default RMIServer initializer.
 * @return An initialized RMIServer object.
 */
- (instancetype _Nullable )init;

#pragma mark Properties accessors

/*!
 * @discussion A getter for accessing connections managed by the server.
 Also look at convenient methods for getting only sections of some type.
 * @return Array of all server's sesions.
 */
- (NSArray* _Nonnull)getConnections;

/*!
 * @discussion A getter for accessing not started connections managed by the server.
 * @return Array of server's not started sesions.
 */
- (NSArray* _Nonnull)getNotStartedConnections;

/*!
 * @discussion A getter for accessing connecting connections managed by the server.
 * @return Array of server's connecting sesions.
 */
- (NSArray* _Nonnull)getConnectingConnections;

/*!
 * @discussion A getter for accessing running connections managed by the server.
 * @return Array of server's running sesions.
 */
- (NSArray* _Nonnull)getOpenConnections;

/*!
 * @discussion A getter for accessing finished connections managed by the server.
 * @return Array of server's finished sesions.
 */
- (NSArray* _Nonnull)getClosedConnections;

#pragma mark Properties mutators

/*!
 * @discussion A method for adding sessions to server.
 * @param newConnection A connection to be added to the server.
 */
- (void)addConnection:(RMIServerConnection* _Nonnull)newConnection;

#pragma mark Registering methods

/*!
 * @discussion A method for registering new object and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetObject Object that must respond to a passed selector.
 */
- (void)registerSelector:(SEL _Nonnull )invocationSelector forObject:(NSObject* _Nonnull)targetObject;

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 */
- (void)registerSelector:(SEL _Nonnull )invocationSelector forClass:(Class _Nonnull)targetClass;

@end
