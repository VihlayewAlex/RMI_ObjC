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

/*!
 * @discussion A constructor for initializing RMIConnection with a given port
 * @param port A target port to start on.
 */
- (instancetype)initWithPort:(NSInteger)port
{
    NSLog(@"- (instancetype)initWithPort:(NSInteger)port");
    self = [super init];
    if (self) {
        portno = port;
        _port = port;
    }
    return self;
}

#pragma mark Opening connection

long portno;
int sockfd, newsockfd;
socklen_t clilen;
char buffer[256];
struct sockaddr_in serv_addr, cli_addr;
long n;

/*!
 * @discussion Trying to open a connection on specified port or o other free port.
 */
- (void)open
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL success = NO;
        while (!success) {
            success = [self openSocket];
            if (!success) {
                NSInteger port = arc4random_uniform(9999);
                portno = port;
                _port = port;
            }
        }
        [self listedOnSocket];
    });
}

/*!
 * @discussion Opens a socket.
 */
- (BOOL)openSocket
{
    NSLog(@"Will open socket");
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
    {
        NSLog(@"ERROR opening socket");
        return NO;
    }
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);
    if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
    {
        NSLog(@"ERROR on binding");
        return NO;
    }
    listen(sockfd, 5);
    clilen = sizeof(cli_addr);
    
    [_delegate didOpen];
    return YES;
}

/*!
 * @discussion Starts listening on socket.
 */
- (void)listedOnSocket
{
    newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
    if (newsockfd < 0)
    {
        NSLog(@"ERROR on accept");
    } else {
        NSLog(@"Accepted connection");
    }
    bzero(buffer,256);
    
    while (read(newsockfd, buffer, 255))
    {
        [_delegate didReceiveString:buffer];
        bzero(buffer,256);
    }
}

/*!
 * @discussion Closes a connection.
 */
- (void)close
{
    close(newsockfd);
    close(sockfd);
    
    [_delegate didClose];
    
    NSLog(@"Closed");
}

@end
