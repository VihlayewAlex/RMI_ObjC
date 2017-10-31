//
//  RMISession.m
//  RMI
//
//  Created by Alex Vihlayew on 26/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMISession.h"

@interface RMISession ()

@property (strong, nonatomic) RMIConnection* connection;
@property (assign, nonatomic) RMISessionState state;

@end

@implementation RMISession

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

- (void)resume
{
    [_connection start];
    _state = RMISessionStateActive;
}

- (void)pause
{
    _state = RMISessionStatePaused;
}

- (void)close
{
    [_connection finish];
    _state = RMISessionStateFinished;
}

@end
