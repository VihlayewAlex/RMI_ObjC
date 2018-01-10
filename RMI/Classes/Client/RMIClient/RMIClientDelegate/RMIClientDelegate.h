//
//  RMIClientDelegate.h
//  RMI
//
//  Created by Alex Vihlayew on 1/5/18.
//  Copyright © 2018 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RMIClientDelegate <NSObject>

- (void)didConnect;
- (void)didGetException:(NSException*)exception;

@end
