//
//  RMIClientConnection.m
//  RMI
//
//  Created by Alex Vihlayew on 10/12/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIClientConnection.h"

@implementation RMIClientConnection

#pragma mark Initialization

- (instancetype)initWithHost:(NSString*)host port:(NSInteger)port
{
    self = [super init];
    if (self) {
        cl_portno = port;
        cl_hostnm = [host cStringUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

const char* cl_hostnm;
int cl_sockfd;
long cl_portno;
long cl_n;
struct sockaddr_in cl_serv_addr;
struct hostent *cl_server;
char cl_buffer[256];

- (void)open
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        cl_sockfd = socket(AF_INET, SOCK_STREAM, 0);
        if (cl_sockfd < 0)
        {
            NSLog(@"ERROR opening socket");
            assert(false);
        }
        cl_server = gethostbyname(cl_hostnm);
        if (cl_server == NULL)
        {
            NSLog(@"ERROR, no such host");
            assert(false);
        }
        bzero((char *) &cl_serv_addr, sizeof(cl_serv_addr));
        cl_serv_addr.sin_family = AF_INET;
        bcopy((char *)cl_server->h_addr,
              (char *)&cl_serv_addr.sin_addr.s_addr,
              cl_server->h_length);
        cl_serv_addr.sin_port = htons(cl_portno);
        if (connect(cl_sockfd, (struct sockaddr *) &cl_serv_addr, sizeof(cl_serv_addr)) < 0)
        {
            NSLog(@"ERROR connecting");
            assert(false);
        } else {
            NSLog(@"Connected");
        }
        bzero(cl_buffer, 256);
        NSLog(@"Opened");
    });
}

- (void)close
{
    close(cl_sockfd);
}

- (void)writeData:(char*)data
{
    strcpy(cl_buffer, data);
    NSLog(@"Will write %s, %lu", cl_buffer, strlen(cl_buffer));
    cl_n = write(cl_sockfd, cl_buffer, strlen(cl_buffer));
    if (cl_n < 0)
    {
        NSLog(@"ERROR writing to socket");
    }
    bzero(cl_buffer,256);
    NSLog(@"Did write");
}

@end
