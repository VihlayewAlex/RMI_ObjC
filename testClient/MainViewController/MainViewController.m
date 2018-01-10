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
@property (weak) IBOutlet NSTextField *stringToSendTextField;
@property (strong, nonatomic) NSString* serverTargetViewControllerUID;

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
    [_client setDelegate:self];
    [_client connect];
}

#pragma mark Color switching

- (IBAction)switchToRed:(id *)sender
{
    [_client invokeMethod:@"switchToRed:" ofTarget:RMIInvocationTargetTypeObject withName:_serverTargetViewControllerUID withParametersDictionary:nil withCompletionBlock:nil];
}

- (IBAction)switchToBlue:(id)sender
{
    [_client invokeMethod:@"switchToBlue:" ofTarget:RMIInvocationTargetTypeObject withName:_serverTargetViewControllerUID withParametersDictionary:nil withCompletionBlock:nil];
}

- (IBAction)switchToGreen:(id)sender
{
    [_client invokeMethod:@"switchToGreen:" ofTarget:RMIInvocationTargetTypeObject withName:_serverTargetViewControllerUID withParametersDictionary:nil withCompletionBlock:nil];
}

#pragma mark String sending

- (IBAction)sendString:(id)sender
{
    [_client invokeMethod:@"displayMessage:" ofTarget:RMIInvocationTargetTypeObject withName:_serverTargetViewControllerUID withParametersDictionary:@{ @"message" : [_stringToSendTextField stringValue] } withCompletionBlock:nil];
}

#pragma mark Shutting down

- (IBAction)shutDown:(id)sender
{
    [_client invokeMethod:@"shutDown:" ofTarget:RMIInvocationTargetTypeObject withName:_serverTargetViewControllerUID withParametersDictionary:nil withCompletionBlock:nil];
}

#pragma mark RMIClientDelegate

- (void)didConnect
{
    NSLog(@"Connected to server.");
    [_client invokeMethod:@"getMainVCObjectUID:" ofTarget:RMIInvocationTargetTypeClass withName:@"MainViewController" withParametersDictionary:nil withCompletionBlock:^(RMIInvocationResponce * _Nullable responce) {
        NSLog(@"Got VC with UID: %@", [[responce responceDictionary] objectForKey:@"UID"]);
        _serverTargetViewControllerUID = [[responce responceDictionary] objectForKey:@"UID"];
    }];
}

- (void)didGetException:(NSException *)exception
{
    NSAlert* alert = [[NSAlert alloc] init];
    [alert setInformativeText:[exception reason]];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert setMessageText:@"Error"];
    [alert runModal];
}


@end
