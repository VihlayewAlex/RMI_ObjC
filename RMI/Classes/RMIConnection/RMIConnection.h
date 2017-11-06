//
//  RMIConnection.h
//  RMI
//
//  Created by Alex Vihlayew on 30/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMIConnection : NSObject

/*!
 * @discussion A constructor for initializing RMIConnection with a given URL
 * @param url A URL of the host to connect to.
 */
- (instancetype)initWithURL:(NSURL*)url;

/*!
 * @discussion Starts a connection to the host.
 */
- (void)start;

/*!
 * @discussion Stops active connection to the host.
 */
- (void)finish;

@end
