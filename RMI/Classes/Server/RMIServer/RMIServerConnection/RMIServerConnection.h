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

@property (assign, nonatomic) NSInteger port;

/*!
 * @discussion A constructor for initializing RMIConnection with a given port
 * @param port A target port to start on.
 */
- (instancetype)initWithPort:(NSInteger)port;

/*!
 * @discussion Opens a connection.
 */
- (void)open;

/*!
 * @discussion Closes a connection.
 */
- (void)close;

@end
