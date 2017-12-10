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

+ (RMIInvocationRequest*)requestForMethodWithName:(NSString*)methodName withArguments:(NSArray*)argumentsArray receiverType:(RMIInvocationTargetType)receiverType;

+ (RMIInvocationResponce*)responceFromData:(NSData*)responceData;

@end
