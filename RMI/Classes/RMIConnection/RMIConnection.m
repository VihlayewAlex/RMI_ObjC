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
@property (strong, nonatomic) NSURL* url;

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

- (void)start
{
    NSError *err = nil;
    if ([_socket connectToUrl:_url withTimeout:5 error:&err]) {
        NSLog(@"Error connecting to url %@", [err localizedDescription]);
    }
}

- (void)finish
{
    [_socket disconnect];
}

#pragma mark GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url
{
    NSLog(@"Did connect to %@", [url absoluteString]);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"Did read data %@", data);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"Did disconnect with error %@", [err localizedDescription]);
}

@end
