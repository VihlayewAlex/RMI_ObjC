//
//  RMIInvocationInfo.h
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 * @brief A list of arguments to be passed to a method.
 */
@property (strong, nonatomic) NSArray* arguments;

/*!
 * @brief The type of message receiver (NSObject of Class).
 */
@property (assign, nonatomic) RMIInvocationTargetType targetType;

/*!
 * @discussion An iniitalizer for RMIInvocationInfo object.
 These objects are used to represent information about method and the receiver.
 * @param methodName A method name.
 * @param arguments An array of arguments to be passed in.
 * @param targetType Message receiver type.
 */
- (instancetype)initWithMethodName:(NSString*)methodName arguments:(NSArray*)arguments targetType:(RMIInvocationTargetType)targetType;

@end
