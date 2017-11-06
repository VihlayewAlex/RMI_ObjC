//
//  RMIRequestResponceMapper.m
//  RMI
//
//  Created by Alex Vihlayew on 02/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIRequestResponceMapper.h"

@implementation RMIRequestResponceMapper

+ (RMIInvocationRequest*)requestForMethodWithName:(NSString*)methodName withArguments:(NSArray*)argumentsArray receiverType:(RMIInvocationTargetType)receiverType
{
    return [[RMIInvocationRequest alloc] init];
}

+ (RMIInvocationResponce*)responceFromData:(NSData*)responceData
{
    return [[RMIInvocationResponce alloc] init];
}

@end
