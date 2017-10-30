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
@property (strong, nonatomic) GCDAsyncSocket* socket;

@end

@implementation RMIConnection

- (instancetype)initWithURL:(NSURL*)url
{
    self = [super init];
    if (self) {
        _socketQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue() socketQueue:_socketQueue];
    }
    return self;
}

#pragma mark GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url
{
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
}

@end
