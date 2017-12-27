//
//  RMIInvocationRequest.h
//  RMI
//
//  Created by Alex Vihlayew on 02/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMIInvocationInfo.h"

@interface RMIInvocationRequest : NSObject

@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString* methodName;
@property (assign, nonatomic) RMIInvocationTargetType targetType;
@property (strong, nonatomic) NSString* targetName;
@property (strong, nonatomic) NSDictionary* parametersDictionary;

@end
