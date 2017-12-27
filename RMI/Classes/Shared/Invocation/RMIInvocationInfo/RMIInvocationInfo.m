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
- (instancetype)initWithMethodName:(NSString*)methodName targetObject:(NSObject*)targetObject
{
    self = [super init];
    if (self) {
        _methodName = methodName;
        _targetObject = targetObject;
    }
    return self;
}

/*!
 * @discussion An iniitalizer for RMIInvocationInfo object.
 These objects are used to represent information about method and the receiver.
 * @param methodName A method name.
 * @param targetClass Message receiver class.
 */
- (instancetype)initWithMethodName:(NSString*)methodName targetClass:(Class)targetClass
{
    self = [super init];
    if (self) {
        _methodName = methodName;
        _targetClassName = [targetClass className];
    }
    return self;
}

#pragma mark Getters

- (NSString*)invocationKey {
    switch (_targetType) {
        case RMIInvocationTargetTypeClass:
            return [[_targetClassName stringByAppendingString:@"+"]
                    stringByAppendingString:_methodName];
            break;
        case RMIInvocationTargetTypeObject:
            return [[[[_targetObject UID] stringValue] stringByAppendingString:@"-"]
                    stringByAppendingString:_methodName];
            break;
        default:
            break;
    }
}

@end