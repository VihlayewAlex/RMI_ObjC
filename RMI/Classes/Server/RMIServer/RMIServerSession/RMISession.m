//
//  RMISession.m
//  RMI
//
//  Created by Alex Vihlayew on 26/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIServerSession.h"

@interface RMIServerSession ()

@property (strong, nonatomic) RMIConnection* connection;

@end

@implementation RMIServerSession

- (instancetype)initWithConfiguration:(RMISessionConfiguration*)configuration
{
    self = [super init];
    if (self) {
        _state = RMISessionStateNotStarted;
        _configuration = configuration;
        _connection = [[RMIConnection alloc] initWithURL:[configuration url]];
    }
    return self;
}

- (void)start
{
    [_connection start];
    _state = RMISessionStateConnecting;
}

- (void)finish
{
    [_connection finish];
    _state = RMISessionStateFinished;
}

#pragma mark RMIConnectionDelegate

- (void)didReceiveInvocationData:(NSData*)invocationData
{
    
}

- (void)didOpen
{
    
}

- (void)didClose
{
    
}

@end
