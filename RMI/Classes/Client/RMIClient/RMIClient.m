//
//  RMIClient.m
//  RMI
//
//  Created by Alex Vihlayew on 12/27/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIClient.h"

@interface RMIClient ()

@property (strong, nonatomic) NSMutableArray* connections;

@end

@implementation RMIClient

#pragma mark Properties mutators

/*!
 * @discussion A method for adding sessions to server.
 * @param newConnection A connection to be added to the server.
 */
- (void)addConnection:(RMIClientConnection* _Nonnull)newConnection {
    [_connections addObject:newConnection];
}

@end
