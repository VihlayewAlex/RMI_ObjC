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
/*!
 * @brief A server unique identifier string.
 */
@property (strong, nonatomic) NSString* serverUID;

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
        _serverUID = @"FIXME_REPLECE_WITH_RANDOM_STRING";
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

/*!
 * @discussion A method for adding sessions to server.
 * @param newSession A session to be added to the server.
 */
- (void)addSession:(RMISession*)newSession {
    [_sessions addObject:newSession];
}

#pragma mark Registering methods

/*!
 * @discussion A method for registering new object and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetObject Object that must respond to a passed selector.
 * @param argumentsArray Array of arguments to be passed to a method
 */
- (void)registerSelector:(SEL)invocationSelector forObject:(NSObject*)targetObject withArgumentsArray:(NSArray*)argumentsArray {
    RMIInvocationInfo* invocationInfo = [[RMIInvocationInfo alloc] initWithMethodName:NSStringFromSelector(invocationSelector)
                                                                            arguments:argumentsArray
                                                                         targetObject:targetObject];
    NSString* invocationKey = [invocationInfo invocationKey];
    [_dispatchTable setObject:invocationInfo forKey:invocationKey];
}

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 * @param argumentsArray Array of arguments to be passed to a method
 */
- (void)registerSelector:(SEL)invocationSelector forClass:(Class)targetClass withArgumentsArray:(NSArray*)argumentsArray {
    RMIInvocationInfo* invocationInfo = [[RMIInvocationInfo alloc] initWithMethodName:NSStringFromSelector(invocationSelector)
                                                                            arguments:argumentsArray
                                                                          targetClass:targetClass];
    NSString* invocationKey = [invocationInfo invocationKey];
    [_dispatchTable setObject:invocationInfo forKey:invocationKey];
}

#pragma mark Removing methods

/*!
 * @discussion A method for unregistering methods from RMI server.
 * @param invocationInfo for method to be unregistered.
 */
- (void)unregisterMethodByInfo:(RMIInvocationInfo*)invocationInfo {
    
}

#pragma mark Method invocation

/*!
 * @discussion A method for invoking class methods that are reristered to RMI server.
 * @param invocationInfo for method to be called.
 */
- (void)invokeClassMethodByInfo:(RMIInvocationInfo*)invocationInfo {
    Class class = NSClassFromString([invocationInfo targetClassName]);
    SEL selector = NSSelectorFromString([invocationInfo methodName]);
    
    NSMethodSignature* methodSignature = [NSMethodSignature methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    for (int i = 0; i < [[invocationInfo arguments] count]; i++) {
        [invocation setArgument:(__bridge void * _Nonnull)([[invocationInfo arguments] objectAtIndex:i]) atIndex:i];
    }
    [invocation setTarget:class];
    [invocation invoke];
}

/*!
 * @discussion A method for invoking instance methods that are reristered to RMI server.
 * @param invocationInfo for method to be called.
 */
- (void)invokeObjectMethodByInfo:(RMIInvocationInfo*)invocationInfo {
    NSObject* object = [invocationInfo targetObject];
    SEL selector = NSSelectorFromString([invocationInfo methodName]);
    
    NSMethodSignature* methodSignature = [NSMethodSignature methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    for (int i = 0; i < [[invocationInfo arguments] count]; i++) {
        [invocation setArgument:(__bridge void * _Nonnull)([[invocationInfo arguments] objectAtIndex:i]) atIndex:i];
    }
    [invocation setTarget:object];
    [invocation invoke];
}

@end
