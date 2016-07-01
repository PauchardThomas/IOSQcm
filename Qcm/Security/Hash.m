//
//  Hash.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "Hash.h"
#include <CommonCrypto/CommonDigest.h>
@implementation Hash
-(NSString*) hash:(NSString*)content {

    const char *cstr = [content cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:content.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
    
}


@end
