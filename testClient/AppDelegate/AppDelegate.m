//
//  AppDelegate.m
//  testClient
//
//  Created by Alex Vihlayew on 12/28/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) MainWindowController* mainWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self setupWindows];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

#pragma mark Setup

- (void)setupWindows
{
    _mainWindowController = [[MainWindowController alloc] initWithNib];
    [_mainWindowController showWindow:nil];
}

@end
