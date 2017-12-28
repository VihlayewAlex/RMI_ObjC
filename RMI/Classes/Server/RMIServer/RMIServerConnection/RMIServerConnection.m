//
//  RMIServerConnection.m
//  RMI
//
//  Created by Alex Vihlayew on 30/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIServerConnection.h"

@interface RMIServerConnection ()

@end

@implementation RMIServerConnection

#pragma mark Initialization

- (instancetype)initWithPort:(NSInteger)port
{
    NSLog(@"- (instancetype)initWithPort:(NSInteger)port");
    self = [super init];
    if (self) {
        portno = port;
    }
    return self;
}

long portno;
int sockfd, newsockfd;
socklen_t clilen;
char buffer[256];
struct sockaddr_in serv_addr, cli_addr;
long n;

- (void)open
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Will open socket");
        
        sockfd = socket(AF_INET, SOCK_STREAM, 0);
        if (sockfd < 0)
        {
            NSLog(@"ERROR opening socket");
            assert(false);
        }
        bzero((char *) &serv_addr, sizeof(serv_addr));
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_addr.s_addr = INADDR_ANY;
        serv_addr.sin_port = htons(portno);
        if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
        {
            NSLog(@"ERROR on binding");
            assert(false);
        }
        listen(sockfd, 5);
        clilen = sizeof(cli_addr);
        newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
        if (newsockfd < 0)
        {
            NSLog(@"ERROR on accept");
            assert(false);
        } else {
            NSLog(@"Accepted connection");
        }
        bzero(buffer,256);
        
        [_delegate didOpen];
        
        while (read(newsockfd, buffer, 255))
        {
            [_delegate didReceiveString:buffer];
            bzero(buffer,256);
        }
    });
}

- (void)close
{
    close(newsockfd);
    close(sockfd);
    
    [_delegate didClose];
    
    NSLog(@"Closed");
}

@end
