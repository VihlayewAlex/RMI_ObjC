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

- (void)connect
{
    [_connection open];
}

- (void)disconnect
{
    [_connection close];
}

- (void)writeString:(char*)data
{
    [_connection writeData:data];
}

#pragma mark Method invocation

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
