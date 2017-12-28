//
//  MainViewController.m
//  testClient
//
//  Created by Alex Vihlayew on 12/28/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) RMIClient* client;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupClient];
}

- (void)setupClient
{
    // Instantiating RMI server
    _client = [[RMIClient alloc] initWithHost:@"localhost" port:12345];

}

- (IBAction)connect:(NSButton *)sender
{
    [_client connect];
}

- (IBAction)invokeClassMethod:(NSButton *)sender
{
    [_client invokeMethod:@"testClassMethod" ofTarget:RMIInvocationTargetTypeClass withName:@"MainViewController" withParametersDictionary:@{ @"key": @"value" }];
}

- (IBAction)invokeInstanceMethod:(NSButton *)sender {
    [_client invokeMethod:@"testInstanceMethod" ofTarget:RMIInvocationTargetTypeObject withName:@"???" withParametersDictionary:@{ @"key": @"value" }];
}

@end
