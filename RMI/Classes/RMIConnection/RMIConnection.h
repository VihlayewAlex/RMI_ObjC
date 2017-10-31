//
//  RMIConnection.h
//  RMI
//
//  Created by Alex Vihlayew on 30/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface RMIConnection : NSObject <GCDAsyncSocketDelegate>

- (instancetype)initWithURL:(NSURL*)url;

- (void)start;

- (void)finish;

@end
