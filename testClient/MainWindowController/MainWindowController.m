//
//  MainWindowController.m
//  testClient
//
//  Created by Alex Vihlayew on 12/28/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

#pragma mark Initialization

- (instancetype)initWithNib
{
    NSString* nibName = NSStringFromClass([self class]);
    self = [super initWithWindowNibName:nibName];
    if (self) {
        [[self window] setTitle:@"Client"];
        [[self window] setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameVibrantDark]];
    }
    return self;
}

#pragma mark Life cycle

- (void)windowDidLoad
{
    NSLog(@"- (void)windowDidLoad");
    [super windowDidLoad];
    
    MainViewController* mainViewController = [[MainViewController alloc] init];
    [[self window] setContentViewController:mainViewController];
}

@end
