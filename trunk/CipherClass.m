//
//  CipherClass.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CipherClass.h"
#import "NSString-Extensions.h"
#import "NSData-Extensions.h"

@implementation CipherClass

+(NSString*) getKey {
    NSString *key = @"123456789";
    return [[key MD5] substringToIndex:16];
}

+(NSString*) encryptString:(NSString*) string  {
    NSData* data = [string dataUsingEncoding: [NSString defaultCStringEncoding]];
    NSData *data2 = [data zlibDeflate];
    NSData* stringCompressed = [data2 AES128MD5EncryptWithKey:[self getKey]];
    NSString *returnString = [stringCompressed base64Encoding];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"=" withString:@"."];
    return returnString;
    
}


+(NSString*) encryptString:(NSString*) string  WithKey:(NSString*) key {
    NSString *tmpKey = [[key MD5] substringToIndex:16];
    NSData* data = [string dataUsingEncoding: [NSString defaultCStringEncoding]];
    NSData *data2 = [data zlibDeflate];
    NSData* stringCompressed = [data2 AES128MD5EncryptWithKey:tmpKey];
    NSString *returnString = [stringCompressed base64Encoding];
    
    returnString = [returnString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"=" withString:@"."];
    return returnString;
    
}


+(NSString*) encryptData:(NSData*) data  {
    NSData *data2 = [data zlibDeflate];
    NSData* stringCompressed = [data2 AES128MD5EncryptWithKey:[self getKey]];
    NSString *returnString = [stringCompressed base64Encoding];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"=" withString:@"."];
    return returnString;
    
}

+(NSString*) encryptData:(NSData*) data  WithKey:(NSString*) key {
    NSString *tmpKey = [[key MD5] substringToIndex:16];
    NSData *data2 = [data zlibDeflate];
    NSData* stringCompressed = [data2 AES128MD5EncryptWithKey:tmpKey];
    NSString *returnString = [stringCompressed base64Encoding];
    
    returnString = [returnString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"=" withString:@"."];
    return returnString;
}


+(NSData*) getDecryptDataFromString:(NSString*) string {
    
    string = [string stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    string = [string stringByReplacingOccurrencesOfString:@"." withString:@"="];
    
    NSMutableData *decoder = [[[NSMutableData alloc] initWithBase64EncodedString:string] autorelease];
    NSData *data3 = [decoder AES128MD5DecryptWithKey:[self getKey]];
    
    return [data3 zlibInflate];    
}


+(NSData*) getDecryptDataFromString:(NSString*) string WithKey:(NSString*) key {
    NSString *tmpKey = [[key MD5] substringToIndex:16];
    
    string = [string stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    string = [string stringByReplacingOccurrencesOfString:@"." withString:@"="];
    
    NSMutableData *decoder = [[[NSMutableData alloc] initWithBase64EncodedString:string] autorelease];
    NSData *data3 = [decoder AES128MD5DecryptWithKey:tmpKey];
    
    return [data3 zlibInflate];
}


+(NSString*) decryptString:(NSString*) string {
    NSString *result = [[[NSString alloc] initWithData:[self getDecryptDataFromString:string] encoding:[NSString defaultCStringEncoding]] autorelease];
    return result; 
}



+(NSString*) decryptString:(NSString*) string WithKey:(NSString*) key {
    NSString *result = [[[NSString alloc] initWithData:[self getDecryptDataFromString:string WithKey:key] encoding:[NSString defaultCStringEncoding]] autorelease];
    return result; 
}

@end
