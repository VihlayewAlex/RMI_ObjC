//
//  RMISession.m
//  RMI
//
//  Created by Alex Vihlayew on 26/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMISession.h"

@implementation RMISession

- (instancetype)initWithConfiguration:(RMISessionConfiguration*)configuration
{
    self = [super init];
    if (self) {
        _configuration = configuration;
    }
    return self;
}

- (void)resume {
    
}

- (void)pause {
    
}

- (void)close {
    
}

@end
