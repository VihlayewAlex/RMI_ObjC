//
//  RMIConnectionDelegate.h
//  RMI
//
//  Created by Alex Vihlayew on 06/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RMIConnectionDelegate <NSObject>

/*!
 * @discussion Called when received some data
 * @param receivedString pointer to a received data
 */
- (void)didReceiveString:(char*)receivedString;

/*!
 * @discussion Called when connection is opened
 */
- (void)didOpen;

/*!
 * @discussion Called when connection is closed
 */
- (void)didClose;

- (void)didRaiseAnException:(NSException*)exception;

@end
