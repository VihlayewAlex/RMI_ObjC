//
//  RMIConnectionDelegate.h
//  RMI
//
//  Created by Alex Vihlayew on 06/11/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RMIConnectionDelegate <NSObject>

- (void)didReceiveString:(char*)receivedString;
- (void)didOpen;
- (void)didClose;

@end
