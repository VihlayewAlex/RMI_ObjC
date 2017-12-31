//
//  RMIConnectionState.h
//  RMI
//
//  Created by Alex Vihlayew on 10/12/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#ifndef RMIConnectionState_h
#define RMIConnectionState_h

/*!
 * @discussion Represents a state of the connection
 */
typedef enum : NSUInteger {
    RMIConnectionStateNotStarted,
    RMIConnectionStateConnecting,
    RMIConnectionStateRunning,
    RMIConnectionStateFinished
} RMIConnectionState;

#endif /* RMIConnectionState_h */
