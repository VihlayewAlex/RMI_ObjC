//
//  RMISession.h
//  RMI
//
//  Created by Alex Vihlayew on 26/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMISessionConfiguration.h"
#import "RMIConnection.h"
#import "RMIRequestResponceMapper.h"
#import "RMIConnectionDelegate.h"
#import "RMISessionDelegate.h"

typedef enum : NSUInteger {
    RMISessionStateNotStarted,
    RMISessionStateConnecting,
    RMISessionStateRunning,
    RMISessionStateFinished
} RMISessionState;

@interface RMISession : NSObject <RMIConnectionDelegate>

@property (weak, nonatomic) id<RMISessionDelegate> delegate;
@property (strong, nonatomic) RMISessionConfiguration* configuration;
@property (assign, nonatomic) RMISessionMode mode;
@property (assign, nonatomic) RMISessionState state;

- (instancetype)initWithConfiguration:(RMISessionConfiguration*)configuration;

- (void)start;

- (void)finish;

@end
