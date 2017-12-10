//
//  RMIConnection.m
//  RMI
//
//  Created by Alex Vihlayew on 30/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "RMIConnection.h"

@interface RMIConnection ()

@property (strong, nonatomic) NSURL* url;

@end

@implementation RMIConnection

- (instancetype)initWithURL:(NSURL*)url
{
    self = [super init];
    if (self) {
        _url = url;
        createSocket();
    }
    return self;
}

- (void)start
{
    
}

- (void)finish
{
  
}

void createSocket() {
    // Creating socket
    __block char* buffer = calloc(256, sizeof(char));
    int PORT_NUMBER = 8181;
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1) { // Checking if socket created successfully
        printf("Error creating socket");
    }
    // Creating server address struct
    struct sockaddr_in server_addr, client_addr;
    // Setting up memory
    bzero((char*) &server_addr , sizeof(server_addr));
    // Setting up server address
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT_NUMBER);
    // Trying to bind socket
    if (bind(sockfd, (struct sockaddr*) &server_addr, sizeof(server_addr)) < 0) {
        printf("Error binding socket");
    }
    // Listening to socket
    listen(sockfd, 5);
    // Accepting data
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int clilen = sizeof(client_addr);
        int newsockfd = accept(sockfd, (struct sockaddr*) &client_addr, &clilen);
        if (newsockfd < 0) {
            printf("Error accepting data");
        }
        bzero(buffer, 256);
        int n = read(newsockfd, buffer, 255);
        if (n < 0) {
            printf("Error reading from socket");
        }
        printf("Here is the message: %s\n", buffer);
    });
}

@end
