//
//  RMIServer.h
//  RMI
//
//  Created by Alex Vihlayew on 22/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMIServer : NSObject

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
 * @discussion A getter for accessing active sessions managed by the server.
 * @return Array of server's active sesions.
 */
- (NSArray*)getActiveSessions;

/*!
 * @discussion A getter for accessing paused sessions managed by the server.
 * @return Array of server's paused sesions.
 */
- (NSArray*)getPausedSessions;

/*!
 * @discussion A getter for accessing closed sessions managed by the server.
 * @return Array of server's closed sesions.
 */
- (NSArray*)getClosedSessions;

/*!
 * @discussion A method for registering new object and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetObject Object that must respond to a passed selector.
 */
- (void)registerSelector:(SEL)invocationSelector forObject:(NSObject*)targetObject;

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 */
- (void)registerSelector:(SEL)invocationSelector forClass:(Class)targetClass;

@end
