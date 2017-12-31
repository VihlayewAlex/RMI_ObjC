//
//  RMI.h
//  RMI
//
//  Created by Alex Vihlayew on 21/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for RMI.
FOUNDATION_EXPORT double RMIVersionNumber;

//! Project version string for RMI.
FOUNDATION_EXPORT const unsigned char RMIVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <RMI/PublicHeader.h>

#import "RMIServer.h" // Used to register methods and receivers and invoke them on remote requests from clients
#import "RMIClient.h" // Used to connect to remote host and to invoke it's methods with a set of parameters

