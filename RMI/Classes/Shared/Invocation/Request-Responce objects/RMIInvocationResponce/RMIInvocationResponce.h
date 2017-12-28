//
//  RMIInvocationResponce.h
//  RMI
//
//  Created by Alex Vihlayew on 02/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMIInvocationResponce : NSObject

@property (assign, nonatomic) NSInteger ID;
@property (assign, nonatomic) BOOL success;
@property (strong, nonatomic) NSDictionary* responceDictionary;

@end
