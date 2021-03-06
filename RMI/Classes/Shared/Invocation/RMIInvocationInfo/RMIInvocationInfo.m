//
//  RMIInvocationInfo.m
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIInvocationInfo.h"

@implementation RMIInvocationInfo

#pragma mark Initialization

/*!
 * @discussion An iniitalizer for RMIInvocationInfo object.
 These objects are used to represent information about method and the receiver.
 * @param methodName A method name.
 * @param targetObject Message receiver object.
 */
- (instancetype)initWithMethodName:(NSString*)methodName targetObjectUID:(NSString*)targetObject
{
    self = [super init];
    if (self) {
        _targetType = RMIInvocationTargetTypeObject;
        _methodName = [methodName copy];
        _targetObjectUID = [targetObject copy];
    }
    return self;
}

/*!
 * @discussion An iniitalizer for RMIInvocationInfo object.
 These objects are used to represent information about method and the receiver.
 * @param methodName A method name.
 * @param targetClass Message receiver class.
 */
- (instancetype)initWithMethodName:(NSString*)methodName targetClassName:(NSString*)targetClass
{
    self = [super init];
    if (self) {
        _targetType = RMIInvocationTargetTypeClass;
        _methodName = [methodName copy];
        _targetClassName = [targetClass copy];
    }
    return self;
}

#pragma mark Getters

/*!
 * @discussion A unique key that identifies receiver and it's target method
 */
- (NSString*)invocationKey {
    switch (_targetType) {
        case RMIInvocationTargetTypeClass:
            return [[_targetClassName stringByAppendingString:@"+"]
                    stringByAppendingString:_methodName];
            break;
        case RMIInvocationTargetTypeObject:
            return [[_targetObjectUID stringByAppendingString:@"-"]
                    stringByAppendingString:_methodName];
            break;
        default:
            break;
    }
}

@end
