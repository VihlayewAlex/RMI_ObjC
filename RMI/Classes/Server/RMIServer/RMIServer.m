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
    NSLog(@"- (instancetype)init");
    self = [super init];
    if (self) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
        _connection = [[RMIServerConnection alloc] initWithPort:12345];
        [_connection setDelegate:self];
    }
    return self;
}

#pragma mark Connection

- (void)start
{
    [_connection open];
}

- (void)stop
{
    [_connection close];
}

#pragma mark Registering methods

/*!
 * @discussion A method for registering new object and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetObject Object that must respond to a passed selector.
 */
- (void)registerSelector:(SEL)invocationSelector forObject:(NSObject*)targetObject {
    RMIInvocationInfo* invocationInfo = [[RMIInvocationInfo alloc] initWithMethodName:NSStringFromSelector(invocationSelector)
                                                                         targetObject:targetObject];
    NSString* invocationKey = [invocationInfo invocationKey];
    [_dispatchTable setObject:invocationInfo forKey:invocationKey];
}

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 */
- (void)registerSelector:(SEL)invocationSelector forClass:(Class)targetClass {
    RMIInvocationInfo* invocationInfo = [[RMIInvocationInfo alloc] initWithMethodName:NSStringFromSelector(invocationSelector)
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
    [_dispatchTable removeObjectForKey:[invocationInfo invocationKey]];
}

#pragma mark Method invocation 

/*!
 * @discussion A method for invoking class methods that are reristered to RMI server.
 * @param invocationInfo for method to be called.
 */
- (void)invokeClassMethodByInfo:(RMIInvocationInfo*)invocationInfo withArguments:(NSDictionary* _Nullable)argumentsDictionary {
    Class class = NSClassFromString([invocationInfo targetClassName]);
    SEL selector = NSSelectorFromString([invocationInfo methodName]);
    
    NSMethodSignature* methodSignature = [NSMethodSignature methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    if (argumentsDictionary) {
        [invocation setArgument:(__bridge void * _Nonnull)(argumentsDictionary) atIndex:0];
    }
    
    [invocation setTarget:class];
    [invocation invoke];
}

/*!
 * @discussion A method for invoking instance methods that are reristered to RMI server.
 * @param invocationInfo for method to be called.
 */
- (void)invokeObjectMethodByInfo:(RMIInvocationInfo*)invocationInfo withArguments:(NSDictionary* _Nullable)argumentsDictionary {
    NSObject* object = [invocationInfo targetObject];
    SEL selector = NSSelectorFromString([invocationInfo methodName]);
    
    NSMethodSignature* methodSignature = [NSMethodSignature methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    if (argumentsDictionary) {
        [invocation setArgument:(__bridge void * _Nonnull)(argumentsDictionary) atIndex:0];
    }

    [invocation setTarget:object];
    [invocation invoke];
}

#pragma mark RMIConnectionDelegate

- (void)didClose
{
    NSLog(@"didClose");
}

- (void)didOpen
{
    NSLog(@"didOpen");
}

- (void)didReceiveData:(NSData *)receivedData
{
    NSLog(@"didReceiveData %@", receivedData);
}

@end
