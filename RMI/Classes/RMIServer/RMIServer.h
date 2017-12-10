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
#import "RMISession.h"
#import "RMISessionDelegate.h"

@interface RMIServer : NSObject <RMISessionDelegate>

/*!
 * @discussion Default RMIServer initializer.
 * @return An initialized RMIServer object.
 */
- (instancetype)init;

/*!
 * @discussion A getter for accessing sessions managed by the server.
 Also look at convenient methods for getting only sections of some type.
 * @return Array of all server's sesions.
 */
- (NSArray*)getSessions;

/*!
 * @discussion A getter for accessing not started sessions managed by the server.
 * @return Array of server's not started sesions.
 */
- (NSArray*)getNotStartedSessions;

/*!
 * @discussion A getter for accessing connecting sessions managed by the server.
 * @return Array of server's connecting sesions.
 */
- (NSArray*)getConnectingSessions;

/*!
 * @discussion A getter for accessing running sessions managed by the server.
 * @return Array of server's running sesions.
 */
- (NSArray*)getRunningSessions;

/*!
 * @discussion A getter for accessing finished sessions managed by the server.
 * @return Array of server's finished sesions.
 */
- (NSArray*)getFinishedSessions;

/*!
 * @discussion A method for registering new object and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetObject Object that must respond to a passed selector.
 * @param argumentsArray Array of arguments to be passed to a method
 */
- (void)registerSelector:(SEL)invocationSelector forObject:(NSObject*)targetObject withArgumentsArray:(NSArray*)argumentsArray;

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 * @param argumentsArray Array of arguments to be passed to a method
 */
- (void)registerSelector:(SEL)invocationSelector forClass:(Class)targetClass withArgumentsArray:(NSArray*)argumentsArray;

@end
