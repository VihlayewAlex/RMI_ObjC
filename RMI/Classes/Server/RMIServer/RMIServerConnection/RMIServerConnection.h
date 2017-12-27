//
//  RMIServerConnection.h
//  RMI
//
//  Created by Alex Vihlayew on 30/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMIConnectionDelegate.h"
#import "RMIConnectionState.h"
#import <sys/socket.h>
#import <netinet/in.h>

@interface RMIServerConnection : NSObject

@property (weak, nonatomic) id<RMIConnectionDelegate> delegate;

@property (assign, nonatomic) RMIConnectionState state;

/*!
 * @discussion A constructor for initializing RMIConnection with a given URL
 * @param address An address of the host to connect to.
 * @param port A target port of the host.
 */
- (instancetype)initWithAddress:(NSString*)address port:(NSInteger)port;

/*!
 * @discussion Starts a connection to the host.
 */
- (void)start;

/*!
 * @discussion Stops active connection to the host.
 */
- (void)finish;

@end
