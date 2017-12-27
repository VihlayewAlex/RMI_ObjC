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
        _targetType = RMIInvocationTargetTypeObject;
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
        _targetType = RMIInvocationTargetTypeClass;
        _methodName = methodName;
        _targetClassName = [targetClass className];
    }
    return self;
}

#pragma mark Getters

- (NSString*)invocationKey {
    NSLog(@"- (NSString*)invocationKey");
    switch (_targetType) {
        case RMIInvocationTargetTypeClass:
            NSLog(@"RMIInvocationTargetTypeClass");
            return [[_targetClassName stringByAppendingString:@"+"]
                    stringByAppendingString:_methodName];
            break;
        case RMIInvocationTargetTypeObject:
            NSLog(@"RMIInvocationTargetTypeObject %@", [_targetObject UID]);
            return [[[_targetObject UID] stringByAppendingString:@"-"]
                    stringByAppendingString:_methodName];
            break;
        default:
            break;
    }
}

@end
