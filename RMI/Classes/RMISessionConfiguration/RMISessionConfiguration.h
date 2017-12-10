//
//  RMISessionConfiguration.h
//  RMI
//
//  Created by Alex Vihlayew on 26/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RMISessionModeClient,
    RMISessionModeServer
} RMISessionMode;

@interface RMISessionConfiguration : NSObject

@property (strong, nonatomic) NSURL* url;
@property (assign, nonatomic) RMISessionMode mode;

@end
