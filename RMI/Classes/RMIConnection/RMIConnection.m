//
//  RMIConnection.m
//  RMI
//
//  Created by Alex Vihlayew on 30/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIConnection.h"

@interface RMIConnection ()

@property (strong, nonatomic) dispatch_queue_t socketQueue;
//@property (strong, nonatomic) SOCKET_TYPE* socket;
@property (strong, nonatomic) NSURL* url;

@end

@implementation RMIConnection

- (instancetype)initWithURL:(NSURL*)url
{
    self = [super init];
    if (self) {
        //_socket =
    }
    return self;
}

- (void)start
{
    
}

- (void)finish
{
    
}

@end
