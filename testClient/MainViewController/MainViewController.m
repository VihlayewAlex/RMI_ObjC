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
    _client = [[RMIClient alloc] init];

}

- (IBAction)connect:(NSButton *)sender {
    [_client connect];
}

@end
