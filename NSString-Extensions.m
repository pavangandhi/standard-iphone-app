//
//  NSString-Extensions.m
//  weltrekorde
//
//  Created by Alexander Herbel on 05.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString-Extensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSString_Extensions)

+ (id)objectWithSqlColumnRepresentation:(NSString *)columnData
{
    return columnData;
}

- (NSString *)sqlColumnRepresentationOfSelf
{
    return self;
}

-(BOOL) isNotEmpty
{
    return !(self == nil
             || [self isKindOfClass:[NSNull class]]
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
    
}

- (NSDate *) date
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"MM-dd-yyyy";
    NSDate *date = [formatter dateFromString:self];
    return date;
}

- (NSString *) trimmedString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL) containsString: (NSString*) substring
{    
    NSRange range = [self rangeOfString: substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

- (NSString *) MD5 {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

-(NSData*) stringToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

-(BOOL)isNumeric:(NSString*)string{
    BOOL isValid = NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}


-(NSString*)nl2br {
    
    NSMutableString *tmp = (NSMutableString*)self;
    tmp = [[tmp stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"]mutableCopy];
    NSString *retVal = [[[NSString alloc] initWithFormat:@"%@",tmp] autorelease];
    [tmp release];
    return retVal;
}

@end
