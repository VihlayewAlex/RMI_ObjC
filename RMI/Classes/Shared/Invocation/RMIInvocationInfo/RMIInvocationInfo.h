//
//  RMIInvocationInfo.h
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+UID_Category.h"

/*!
 * @typedef RMIInvocationTargetType.
 * @brief Represents message target type.
 * @constant RMIInvocationTargetTypeObject An NSObject.
 * @constant RMIInvocationTargetTypeClass A Class.
 */
typedef enum : NSUInteger {
    RMIInvocationTargetTypeObject,
    RMIInvocationTargetTypeClass
} RMIInvocationTargetType;

@interface RMIInvocationInfo : NSObject

/*!
 * @brief Name of method to be called.
 */
@property (strong, nonatomic) NSString* methodName;

/*!
 * @brief The type of message receiver (NSObject of Class).
 */
@property (assign, nonatomic) RMIInvocationTargetType targetType;

/*!
 * @brief The message receiver object.
 */
@property (strong, nonatomic) NSObject* targetObject;

/*!
 * @brief The message receiver class's name.
 */
@property (strong, nonatomic) NSString* targetClassName;

/*!
 * @discussion An iniitalizer for RMIInvocationInfo object.
 These objects are used to represent information about method and the receiver.
 * @param methodName A method name.
 * @param targetObject Message receiver object.
 */
- (instancetype)initWithMethodName:(NSString*)methodName targetObject:(NSObject*)targetObject;

/*!
 * @discussion An iniitalizer for RMIInvocationInfo object.
 These objects are used to represent information about method and the receiver.
 * @param methodName A method name.
 * @param targetClass Message receiver class.
 */
- (instancetype)initWithMethodName:(NSString*)methodName targetClass:(Class)targetClass;

- (NSString*)invocationKey;

@end
