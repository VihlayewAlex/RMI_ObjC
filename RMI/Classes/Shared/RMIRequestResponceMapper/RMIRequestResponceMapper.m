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

+ (RMIInvocationRequest*)requestFromData:(NSData*)requestData
{
    return [[RMIInvocationRequest alloc] init];
}


+ (RMIInvocationResponce*)responceFromData:(NSData*)responceData
{
    RMIInvocationResponce* responce = (RMIInvocationResponce*)responceData;
    return responce;
}

+ (NSData*)dataFromInvocationRequest:(RMIInvocationRequest*)invocationRequest
{
    
    return [[NSData alloc] init];
}

@end
