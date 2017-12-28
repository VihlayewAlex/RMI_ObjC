//
//  RMIRequestResponceMapper.h
//  RMI
//
//  Created by Alex Vihlayew on 02/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMIInvocationInfo.h"
#import "RMIInvocationRequest.h"
#import "RMIInvocationResponce.h"

@interface RMIRequestResponceMapper : NSObject

#pragma mark Client -> (Server)

+ (RMIInvocationRequest*)requestFromData:(NSData*)requestData;

#pragma mark Server -> (Client)

+ (RMIInvocationResponce*)responceFromData:(NSData*)responceData;

#pragma mark (Client) -> Server

+ (NSData*)dataFromInvocationRequest:(RMIInvocationRequest*)invocationRequest;

#pragma mark (Server) -> Client

+ (NSData*)dataFromInvocationResponce:(RMIInvocationResponce*)invocationResponce;

@end
