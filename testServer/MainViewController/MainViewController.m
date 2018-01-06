//
//  MainViewController.m
//  testServer
//
//  Created by Alex Vihlayew on 12/27/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "MainViewController.h"

static MainViewController* mainViewControllerRef;

@interface MainViewController ()

@property (weak) IBOutlet NSTextField *serverStatusLabel;
@property (weak) IBOutlet NSTextField *messageLabel;

@property (strong, nonatomic) RMIServer* server;

@end

@implementation MainViewController

+ (NSDictionary*)getMainVCObjectUID:(NSDictionary*)arguments
{
    return @{ @"UID" : [mainViewControllerRef UID] };
}

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        mainViewControllerRef = self;
        NSLog(@"inited VC with UID: %@", [mainViewControllerRef UID]);
    }
    return self;
}

#pragma mark Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupServer];
}

- (void)setupServer
{
    // Instantiating RMI server
    _server = [[RMIServer alloc] initWithPort:12345];
    // Registering selectors
    [_server registerSelector:@selector(getMainVCObjectUID:) forClass:[self class]];
    [_server registerSelector:@selector(switchToRed:) forObject:self];
    [_server registerSelector:@selector(switchToBlue:) forObject:self];
    [_server registerSelector:@selector(switchToGreen:) forObject:self];
    [_server registerSelector:@selector(displayMessage:) forObject:self];
    [_server registerSelector:@selector(shutDown:) forObject:self];
}

- (IBAction)connect:(NSButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [_server startWithCompletionBlock:^(NSInteger portNumber)
     {
        [[weakSelf serverStatusLabel] setStringValue:[NSString stringWithFormat:@"Connected to: %lu", portNumber]];
    }];
}

#pragma mark Color switching

- (NSDictionary*)switchToRed:(NSDictionary*)arguments
{
    NSLog(@"switchToRed called");
    [[[self view] layer] setBackgroundColor:[[NSColor redColor] CGColor]];
    return [NSDictionary new];
}

- (NSDictionary*)switchToBlue:(NSDictionary*)arguments
{
    NSLog(@"switchToBlue called");
    [[[self view] layer] setBackgroundColor:[[NSColor blueColor] CGColor]];
    return [NSDictionary new];
}

- (NSDictionary*)switchToGreen:(NSDictionary*)arguments
{
    NSLog(@"switchToGreen called");
    [[[self view] layer] setBackgroundColor:[[NSColor greenColor] CGColor]];
    return [NSDictionary new];
}

#pragma mark String displaying

- (NSDictionary*)displayMessage:(NSDictionary*)arguments
{
    [_messageLabel setStringValue:[arguments objectForKey:@"message"]];
    return [NSDictionary new];
}

#pragma mark Shutting down

- (NSDictionary*)shutDown:(NSDictionary*)arguments
{
    exit(0);
    return [NSDictionary new];
}

@end
