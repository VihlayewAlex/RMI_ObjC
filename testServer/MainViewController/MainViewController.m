//
//  MainViewController.m
//  testServer
//
//  Created by Alex Vihlayew on 12/27/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak) IBOutlet NSTextField *serverStatusLabel;

@property (strong, nonatomic) RMIServer* server;

@end

@implementation MainViewController

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
    [_server registerSelector:@selector(testInstanceMethodWithArgs:) forObject:self];
    [_server registerSelector:@selector(testClassMethodWithArgs:) forClass:[self class]];
}

- (IBAction)connect:(NSButton *)sender {
    [_server startWithCompletionBlock:^(NSInteger portNumber) {
        __weak typeof(self) weakSelf = self;
        [[weakSelf serverStatusLabel] setStringValue:[NSString stringWithFormat:@"Connected to: %lu", portNumber]];
    }];
}

- (void)testInstanceMethodWithArgs:(NSDictionary*)arguments
{
    NSLog(@"testInstanceMethod called");
}

+ (void)testClassMethodWithArgs:(NSDictionary*)arguments
{
    NSLog(@"testClassMethod called");
}

@end
