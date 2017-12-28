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

/*!
 * @brief Dictionary that is used for storing registered objects.
 */
@property (strong, nonatomic) NSMutableDictionary* registeredObjects;

@end


@implementation RMIServer

#pragma mark Initialization

/*!
 * @discussion Default RMIServer initializer.
 * @param port A port to start server on.
 * @return An initialized RMIServer object.
 */
- (instancetype)initWithPort:(NSInteger)port
{
    self = [super init];
    if (self) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
        _registeredObjects = [[NSMutableDictionary alloc] init];
        _connection = [[RMIServerConnection alloc] initWithPort:port];
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
                                                                      targetObjectUID:[targetObject UID]];
    NSString* invocationKey = [invocationInfo invocationKey];
    [_dispatchTable setObject:invocationInfo forKey:invocationKey];
    [_registeredObjects setObject:targetObject forKey:invocationKey];
}

/*!
 * @discussion A method for registering new class and selector to server.
 This adds all needed info to a dictionary that mapps method calls names to the invocation information.
 * @param invocationSelector Selector for method to be visible for server.
 * @param targetClass Class that must respond to a passed selector.
 */
- (void)registerSelector:(SEL)invocationSelector forClass:(Class)targetClass {
    RMIInvocationInfo* invocationInfo = [[RMIInvocationInfo alloc] initWithMethodName:NSStringFromSelector(invocationSelector)
                                                                      targetClassName:[targetClass className]];
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
    NSLog(@"%@", class);
    SEL selector = NSSelectorFromString([invocationInfo methodName]);
    NSLog(@"%@", selector);
    [class performSelector:selector withObject:argumentsDictionary];
    NSLog(@"Performed selector on target class");
}

/*!
 * @discussion A method for invoking instance methods that are reristered to RMI server.
 * @param invocationInfo for method to be called.
 */
- (void)invokeObjectMethodByInfo:(RMIInvocationInfo*)invocationInfo withArguments:(NSDictionary* _Nullable)argumentsDictionary {
    NSObject* object = [_registeredObjects objectForKey:[invocationInfo invocationKey]];
    NSLog(@"%@", object);
    NSLog(@"%@", [invocationInfo invocationKey]);
    SEL selector = NSSelectorFromString([invocationInfo methodName]);
    NSLog(@"%@", selector);
    [object performSelector:selector withObject:argumentsDictionary];
    NSLog(@"Performed selector on target object");
}

#pragma mark RMIConnectionDelegate

- (void)didClose
{
    NSLog(@"didClose");
}

- (void)didOpen
{
    NSLog(@"Server did open");
}

- (void)didReceiveString:(char *)receivedString
{
    NSLog(@"didReceiveData %s", receivedString);
    NSString* string = [NSString stringWithCString:receivedString encoding:NSASCIIStringEncoding];
    NSData* data = [string dataUsingEncoding:NSASCIIStringEncoding];
    RMIInvocationRequest* request = [RMIRequestResponceMapper requestFromData:data];
    RMIInvocationInfo* info;
    switch ([request targetType])
    {
        case RMIInvocationTargetTypeClass:
            info = [[RMIInvocationInfo alloc] initWithMethodName:[request methodName] targetClassName:(NSString* _Nonnull)NSClassFromString([request targetName])];
            [self invokeClassMethodByInfo:info withArguments:[request parametersDictionary]];
            break;
            
        case RMIInvocationTargetTypeObject:
            info = [[RMIInvocationInfo alloc] initWithMethodName:[request methodName] targetObjectUID:[request targetName]];
            [self invokeObjectMethodByInfo:info withArguments:[request parametersDictionary]];
            break;
    }
}

@end
