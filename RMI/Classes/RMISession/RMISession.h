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

typedef enum : NSUInteger {
    RMISessionStateNotStarted,
    RMISessionStateActive,
    RMISessionStatePaused,
    RMISessionStateFinished
} RMISessionState;

@interface RMISession : NSObject

@property (strong, nonatomic) RMISessionConfiguration* configuration;
@property (assign, nonatomic) RMISessionMode* mode;

- (instancetype)initWithConfiguration:(RMISessionConfiguration*)configuration;

- (void)resume;

- (void)pause;

- (void)close;

@end
