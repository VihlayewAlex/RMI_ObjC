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

#pragma mark Properties

/*!
 * @discussion Keeps reference to a delegate object.
 */
@property (weak, nonatomic, nullable) id<RMIConnectionDelegate> delegate;

/*!
 * @discussion State of connection.
 */
@property (assign, nonatomic) RMIConnectionState state;

/*!
 * @discussion Connection port.
 */
@property (assign, nonatomic) NSInteger port;

#pragma mark Initialization

/*!
 * @discussion A constructor for initializing RMIConnection with a given port
 * @param port A target port to start on.
 */
- (instancetype _Nonnull )initWithPort:(NSInteger)port;

#pragma mark Opening connection

/*!
 * @discussion Trying to open a connection on specified port or o other free port.
 */
- (void)open;

/*!
 * @discussion Closes a connection.
 */
- (void)close;

/*!
 * @discussion Sends data to client.
 */
- (void)writeData:(const char* _Nullable)data;

@end
