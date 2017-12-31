//
//  RMIClient.m
//  RMI
//
//  Created by Alex Vihlayew on 12/27/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIClient.h"

@interface RMIClient ()

@property (strong, nonatomic) RMIClientConnection* connection;

@end

@implementation RMIClient

#pragma mark Initialization

/*!
 * @discussion Default RMIServer initializer.
 * @return An initialized RMIServer object.
 */
- (instancetype)initWithHost:(NSString*)host port:(NSInteger)port
{
    self = [super init];
    if (self) {
        _connection = [[RMIClientConnection alloc] initWithHost:host port:port];
        [_connection setDelegate:self];
    }
    return self;
}

#pragma mark Connection

/*!
 * @discussion Starts connection to the server.
 */
- (void)connect
{
    [_connection open];
}

/*!
 * @discussion Stops connection to the server.
 */
- (void)disconnect
{
    [_connection close];
}

/*!
 * @discussion Sends data to server.
 */
- (void)writeString:(const char* _Nullable)data
{
    [_connection writeData:data];
}

#pragma mark Method invocation

/*!
 * @discussion Invokes remote class / object method on the connected server
 * @param methodName A string representation of remote method selector
 * @param targetType A type of remote message receiver
 * @param targetName A name of a message receiver
 * @param parametersDictionary A discionary of parameters to pass to remote method
 */
- (void)invokeMethod:(NSString*)methodName ofTarget:(RMIInvocationTargetType)targetType withName:(NSString*)targetName withParametersDictionary:(NSDictionary*)parametersDictionary
{
    RMIInvocationRequest* invocationRequest = [[RMIInvocationRequest alloc] init];
    [invocationRequest setID:arc4random_uniform(999)];
    [invocationRequest setMethodName:methodName];
    [invocationRequest setTargetType:targetType];
    [invocationRequest setTargetName:targetName];
    [invocationRequest setParametersDictionary:parametersDictionary];
    NSData* data = [RMIRequestResponceMapper dataFromInvocationRequest:invocationRequest];
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self writeString:[dataString cStringUsingEncoding:NSASCIIStringEncoding]];
}

#pragma mark RMIConnectionDelegate

- (void)didClose
{
    NSLog(@"didClose");
}

- (void)didOpen
{
    NSLog(@"Client did open");
}

- (void)didReceiveString:(char *)receivedString
{
    NSLog(@"didReceiveData %s", receivedString);
}

@end
