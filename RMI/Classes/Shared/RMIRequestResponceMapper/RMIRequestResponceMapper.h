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

/*!
 * @discussion Translates received NSData to RMIInvocationRequest.
 * @param requestData data received from client
 * @return invocation request object filled with invocation data
 */
+ (RMIInvocationRequest*)requestFromData:(NSData*)requestData;

#pragma mark Server -> (Client)

/*!
 * @discussion Translates received NSData to RMIInvocationResponce.
 * @param responceData data received from server
 * @return invocation responce object filled with invocation data
 */
+ (RMIInvocationResponce*)responceFromData:(NSData*)responceData;

#pragma mark (Client) -> Server

/*!
 * @discussion Translates RMIInvocationRequest to an NSData.
 * @param invocationRequest request to convert to NSData object
 * @return data that represents invocation request
 */
+ (NSData*)dataFromInvocationRequest:(RMIInvocationRequest*)invocationRequest;

#pragma mark (Server) -> Client

/*!
 * @discussion Translates RMIInvocationResponce to an NSData.
 * @param invocationResponce responce to convert to NSData object
 * @return data that represents invocation responce
 */
+ (NSData*)dataFromInvocationResponce:(RMIInvocationResponce*)invocationResponce;

@end
