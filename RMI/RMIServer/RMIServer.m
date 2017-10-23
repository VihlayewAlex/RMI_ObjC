//
//  RMIServer.m
//  RMI
//
//  Created by Alex Vihlayew on 22/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIServer.h"

@interface RMIServer ()

/*!
 * @brief Array of sessions that are managed by this server.
 */
@property (strong, nonatomic) NSMutableArray* sessions;
/*!
 * @brief Dictionary that is used for mapping function calls to invocation data objects.
 */
@property (strong, nonatomic) NSMutableDictionary* dispatchTable;

@end


@implementation RMIServer

#pragma mark Initialization

/*!
 * @discussion Default RMIServer initializer.
 * @return An initialized RMIServer object.
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
        _sessions = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark Properties accessors

/*!
 * @discussion A getter for accessing sessions managed by the server.
 Also look at convenient methods for getting only sections of some type.
 * @return Array of all server's sesions.
 */
- (NSArray*)getSessions {
    return _sessions;
}

/*!
 * @discussion A getter for accessing active sessions managed by the server.
 * @return Array of server's active sesions.
 */
- (NSArray*)getActiveSessions {
    return _sessions; // FIXME: filter result
}

/*!
 * @discussion A getter for accessing paused sessions managed by the server.
 * @return Array of server's paused sesions.
 */
- (NSArray*)getPausedSessions {
    return _sessions; // FIXME: filter result
}

/*!
 * @discussion A getter for accessing closed sessions managed by the server.
 * @return Array of server's closed sesions.
 */
- (NSArray*)getClosedSessions {
    return _sessions; // FIXME: filter result
}

#pragma mark Properties mutators

//- (void)addSession:(RMISession*)newSession {
//    [_sessions addObject:newSession];
//}

#pragma mark Registering methods

/*!
 * @discussion A method for registering new object and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetObject Object that must respond to a passed selector.
 */
- (void)registerSelector:(SEL)invocationSelector forObject:(NSObject*)targetObject {
    // FIXME: Add implementation
}

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 */
- (void)registerSelector:(SEL)invocationSelector forClass:(Class)targetClass {
    // FIXME: Add implementation
}

@end
