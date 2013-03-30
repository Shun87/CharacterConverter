//
//  Conveter.m
//  CharacterConverter
//
//  Created by chenshun on 13-3-30.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "NSString+Conveter.h"
#include "cconv.h"
#import "CCEncoding.h"

@implementation NSString(Conveter)

- (NSString *)convertString:(NSString *)src withEnc:(const char *)enc
{
    const char *inBuf= [self UTF8String];
    int inLength = strlen(inBuf);
    char *outbuf = (char *)malloc(inLength * 4);
    bzero(outbuf, inLength * 4);
    const char *pInBuf = inBuf;
    char *pOutBuf = outbuf;
    size_t outlen = inLength * 4;
    
    //    iconv_t cd = iconv_open( "GBK", "UTF-8");
    //    iconv(cd, &inb, (size_t *)&inlen, &outb,&outlen);
    //    outlen = strlen(outbuf);
    //    iconv_close(cd);
    
    cconv_t cd = cconv_open(enc, CCONV_CODE_UTF);
    if (cd < 0)
    {
        free(outbuf);
        return nil;
    }
    
    // cconv is the same as iconv, pInBuf and pOutBuf will be changed;
    size_t result = cconv(cd, &pInBuf, (size_t *)&inLength, &pOutBuf, &outlen);
    if (result == (size_t)-1)
    {
        free(outbuf);
        return nil;
    }
    
    outlen = strlen(outbuf);
    cconv_close(cd);
    
    NSString *convertedStr = nil;
    if (strcmp(enc, CCONV_CODE_BIG) == 0)
    {
        convertedStr = [CCEncoding BigToUnicode:outbuf];
    }
    else if (strcmp(enc, CCONV_CODE_GBL) == 0)
    {
        convertedStr = [CCEncoding GB18030ToUnicode:outbuf];
    }
    free(outbuf);
    
    return convertedStr;
}

- (NSString *)traditinalString
{
    return [self convertString:self withEnc:CCONV_CODE_BIG];
}

- (NSString *)simplizeString
{
    return [self convertString:self withEnc:CCONV_CODE_GBL];
}

@end
