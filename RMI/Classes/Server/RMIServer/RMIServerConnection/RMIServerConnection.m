//
//  RMIServerConnection.m
//  RMI
//
//  Created by Alex Vihlayew on 30/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIServerConnection.h"

@interface RMIServerConnection ()

@end

@implementation RMIServerConnection

- (instancetype)initWithAddress:(NSString*)address port:(NSInteger)port
{
    self = [super init];
    if (self) {
        createSocket();
    }
    return self;
}

- (void)start
{
    
}

- (void)finish
{
  
}

void createSocket() {
    // Add POSIX socket code
}

@end
