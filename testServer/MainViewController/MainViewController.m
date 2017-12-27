//
//  MainViewController.m
//  testServer
//
//  Created by Alex Vihlayew on 12/27/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

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
    _server = [[RMIServer alloc] init];
    // Registering selectors
    [_server registerSelector:@selector(testInstanceMethod) forObject:self];
    [_server registerSelector:@selector(testClassMethod) forClass:[self class]];
}

- (void)testInstanceMethod
{
    NSLog(@"testInstanceMethod called");
}

+ (void)testClassMethod
{
    NSLog(@"testClassMethod called");
}

@end
