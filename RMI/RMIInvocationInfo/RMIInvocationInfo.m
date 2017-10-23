//
//  RMIInvocationInfo.m
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIInvocationInfo.h"

@implementation RMIInvocationInfo

/*!
 * @discussion An iniitalizer for RMIInvocationInfo object.
 These objects are used to represent information about method and the receiver.
 * @param methodName A method name.
 * @param arguments An array of arguments to be passed in.
 * @param targetType Message receiver type.
 */
- (instancetype)initWithMethodName:(NSString*)methodName arguments:(NSArray*)arguments targetType:(RMIInvocationTargetType)targetType
{
    self = [super init];
    if (self) {
        _methodName = methodName;
        _arguments = arguments;
        _targetType = targetType;
    }
    return self;
}

@end
