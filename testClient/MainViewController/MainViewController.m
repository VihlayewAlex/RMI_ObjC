//
//  MainViewController.m
//  testClient
//
//  Created by Alex Vihlayew on 12/28/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak) IBOutlet NSTextField *portTextField;

@property (strong, nonatomic) RMIClient* client;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (IBAction)connect:(NSButton *)sender
{
    if ([[_portTextField stringValue] isEqualToString:@""]) { return; }
    NSInteger portNumber = [[_portTextField stringValue] integerValue];
    _client = [[RMIClient alloc] initWithHost:@"localhost" port:portNumber];
    [_client connect];
}

- (IBAction)invokeClassMethod:(NSButton *)sender
{
    [_client invokeMethod:@"testClassMethodWithArgs:" ofTarget:RMIInvocationTargetTypeClass withName:@"MainViewController" withParametersDictionary:nil];
}

- (IBAction)invokeInstanceMethod:(NSButton *)sender {
    [_client invokeMethod:@"testInstanceMethodWithArgs:" ofTarget:RMIInvocationTargetTypeObject withName:@"???" withParametersDictionary:@{ @"key": @"value" }];
}

@end
