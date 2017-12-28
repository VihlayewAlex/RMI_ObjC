//
//  RMIClientConnection.h
//  RMI
//
//  Created by Alex Vihlayew on 10/12/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMIConnectionState.h"
#import "RMIConnectionDelegate.h"
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

@interface RMIClientConnection : NSObject

@property (weak, nonatomic) id<RMIConnectionDelegate> delegate;

@property (assign, nonatomic) RMIConnectionState state;

/*!
 * @discussion A constructor for initializing RMIConnection with a given host and port
 * @param host A host to connect to.
 * @param port A target port connect.
 */
- (instancetype)initWithHost:(NSString*)host port:(NSInteger)port;

/*!
 * @discussion Opens a connection.
 */
- (void)open;

/*!
 * @discussion Closes a connection.
 */
- (void)close;

/*!
 * @discussion Writes data to the socket
 * @param data A data to be written.
 */
- (void)writeData:(char*)data;

@end
