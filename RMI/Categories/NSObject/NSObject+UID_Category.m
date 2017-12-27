//
//  NSObject+NSObject_Category.m
//  RMI
//
//  Created by Alex Vihlayew on 23/10/2017.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "NSObject+UID_Category.h"

@interface NSObject ()

@end


@implementation NSObject (UID_Category)

- (NSString*)UID
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (uint32_t)[data length], result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
