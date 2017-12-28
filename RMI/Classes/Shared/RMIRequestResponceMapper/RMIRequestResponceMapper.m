//
//  RMIRequestResponceMapper.m
//  RMI
//
//  Created by Alex Vihlayew on 02/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIRequestResponceMapper.h"

@implementation RMIRequestResponceMapper

#pragma mark Client -> (Server)

+ (RMIInvocationRequest*)requestFromData:(NSData*)requestData
{
    NSError* error;
    NSDictionary* requestDictionary = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingAllowFragments error:&error];
    if (error)
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    RMIInvocationRequest* request = [[RMIInvocationRequest alloc] init];
    [request setID:[(NSNumber*)[requestDictionary objectForKey:@"id"] integerValue]];
    [request setTargetType:[(NSNumber*)[requestDictionary objectForKey:@"targetType"] unsignedIntegerValue]];
    [request setTargetName:(NSString*)[requestDictionary objectForKey:@"targetName"]];
    [request setMethodName:(NSString*)[requestDictionary objectForKey:@"methodName"]];
    [request setParametersDictionary:[requestDictionary objectForKey:@"parameters"]];
    return request;
}

#pragma mark Server -> (Client)

+ (RMIInvocationResponce*)responceFromData:(NSData*)responceData
{
    NSError* error;
    NSDictionary* responceDictionary = [NSJSONSerialization JSONObjectWithData:responceData options:NSJSONReadingAllowFragments error:&error];
    if (error)
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    RMIInvocationResponce* responce = [[RMIInvocationResponce alloc] init];
    [responce setID:[(NSNumber*)[responceDictionary objectForKey:@"id"] integerValue]];
    [responce setResponceDictionary:[responceDictionary objectForKey:@"parameters"]];
    [responce setSuccess:[(NSNumber*)[responceDictionary objectForKey:@"success"] boolValue]];
    return responce;
}

#pragma mark (Client) -> Server

+ (NSData*)dataFromInvocationRequest:(RMIInvocationRequest*)invocationRequest
{
    NSDictionary* invocationRequestDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithInteger:[invocationRequest ID]], @"id",
                                                [NSNumber numberWithUnsignedInteger:[invocationRequest targetType]], @"targetType",
                                                [invocationRequest targetName], @"targetName",
                                                [invocationRequest methodName], @"methodName",
                                                [invocationRequest parametersDictionary], @"parameters", nil];
    NSLog(@"%@, %@", invocationRequestDictionary, [invocationRequest targetName]);
    NSError* error;
    NSData* invocationRequestData = [NSJSONSerialization dataWithJSONObject:invocationRequestDictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (error)
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    return invocationRequestData;
}

#pragma mark (Server) -> Client

+ (NSData*)dataFromInvocationResponce:(RMIInvocationResponce*)invocationResponce
{
    NSDictionary* invocationResponceDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  [NSNumber numberWithInteger:[invocationResponce ID]], @"id",
                                                  [NSNumber numberWithBool:[invocationResponce success]], @"success",
                                                  [invocationResponce responceDictionary], @"parameters", nil];
    NSError* error;
    NSData* invocationResponceData = [NSJSONSerialization dataWithJSONObject:invocationResponceDictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (error)
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    return invocationResponceData;
}

@end
