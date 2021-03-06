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

/*
 * @brief A completion block to be executed on server socket opening
 */
@property (nonatomic, copy, nonnull) void (^connectinCompletionBlock)(NSInteger);

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

/*!
 * @discussion Opens default server connection.
 * @param completion A completion block to be executed on server start.
 */
- (void)startWithCompletionBlock:(void(^)(NSInteger portNumber))completion
{
    _connectinCompletionBlock = completion;
    [_connection open];
}

/*!
 * @discussion Closes default server connection.
 */
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
    // Logging selector registration
    NSLog(@"Registered instance method selector: %@", NSStringFromSelector(invocationSelector));
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
    // Logging selector registration
    NSLog(@"Registered class method selector: %@", NSStringFromSelector(invocationSelector));
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
 * @param requestID An ID used to map request to a responce.
 */
- (void)invokeClassMethodByInfo:(RMIInvocationInfo*)invocationInfo forRequestWithID:(NSInteger)requestID withArguments:(NSDictionary* _Nullable)argumentsDictionary
{
    // Getting target class
    Class targetClass = NSClassFromString([invocationInfo targetClassName]);
    NSLog(@"Got class: %@", targetClass);
    // Getting target's method selector
    SEL methodSelector = NSSelectorFromString([invocationInfo methodName]);
    NSLog(@"Will invoke class method by selector: %@", NSStringFromSelector(methodSelector));
    // Getting method signature by selector
    NSMethodSignature* methodSignature = [targetClass methodSignatureForSelector:methodSelector];
    // Instantiating NSInvocation
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:methodSelector];
    [invocation setTarget:targetClass];
    [invocation setArgument:&argumentsDictionary atIndex:2];
    [invocation invoke];
    
    NSDictionary* result;
    [invocation getReturnValue:&result];
    
    if (result) {
        [self sendResponceForRequestWithID:requestID withSuccess:YES withArguments:result];
    }
    
    NSLog(@"Performed selector on target class");
}

/*!
 * @discussion A method for invoking instance methods that are reristered to RMI server.
 * @param invocationInfo for method to be called.
 * @param requestID An ID used to map request to a responce.
 */
- (void)invokeObjectMethodByInfo:(RMIInvocationInfo*)invocationInfo forRequestWithID:(NSInteger)requestID withArguments:(NSDictionary* _Nullable)argumentsDictionary
{
    // Getting target object
    NSObject* targetObject = [_registeredObjects objectForKey:[invocationInfo invocationKey]];
    NSLog(@"Got object: %@ for key: %@", targetObject, [invocationInfo invocationKey]);
    // Getting target's method selector
    SEL methodSelector = NSSelectorFromString([invocationInfo methodName]);
    NSLog(@"Will invoke instance method by selector: %@", NSStringFromSelector(methodSelector));
    // Getting method signature by selector
    NSMethodSignature* methodSignature = [targetObject methodSignatureForSelector:methodSelector];
    // Instantiating NSInvocation
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:methodSelector];
    [invocation setTarget:targetObject];
    [invocation setArgument:&argumentsDictionary atIndex:2];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [invocation invoke];
        
        NSDictionary* result;
        [invocation getReturnValue:&result];
        
        if (result) {
            [self sendResponceForRequestWithID:requestID withSuccess:YES withArguments:result];
        }
        
        NSLog(@"Performed selector on target object");
    });
}

#pragma mark Responding

- (void)sendResponceForRequestWithID:(NSInteger)ID withSuccess:(BOOL)success withArguments:(NSDictionary*)arguments
{
    RMIInvocationResponce* responce = [[RMIInvocationResponce alloc] init];
    [responce setID:ID];
    [responce setSuccess:success];
    [responce setResponceDictionary:arguments];
    
    NSData* responceData = [RMIRequestResponceMapper dataFromInvocationResponce:responce];
    NSString* dataString = [[NSString alloc] initWithData:responceData encoding:NSUTF8StringEncoding];
    
    [_connection writeData:[dataString cStringUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark RMIConnectionDelegate

- (void)didClose
{
    NSLog(@"didClose");
}

- (void)didOpen
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _connectinCompletionBlock([_connection port]);
    });
    NSLog(@"Server did open");
}

- (void)didReceiveString:(char *)receivedString
{
    NSLog(@"didReceiveData %s", receivedString);
    NSString* string = [NSString stringWithCString:receivedString encoding:NSUTF8StringEncoding];
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    RMIInvocationRequest* request = [RMIRequestResponceMapper requestFromData:data];
    RMIInvocationInfo* info;
    switch ([request targetType])
    {
        case RMIInvocationTargetTypeClass:
            info = [[RMIInvocationInfo alloc] initWithMethodName:[request methodName] targetClassName:[request targetName]];
            [self invokeClassMethodByInfo:info
                         forRequestWithID:[request ID]
                            withArguments:[request parametersDictionary]];
            break;
        case RMIInvocationTargetTypeObject:
            info = [[RMIInvocationInfo alloc] initWithMethodName:[request methodName] targetObjectUID:[request targetName]];
            [self invokeObjectMethodByInfo:info
                          forRequestWithID:[request ID]
                             withArguments:[request parametersDictionary]];
            break;
    }
}

- (void)didRaiseAnException:(NSException *)exception {
    NSLog(@"%@", [exception reason]);
}


@end
