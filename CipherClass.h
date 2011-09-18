//
//  CipherClass.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CipherClass : NSObject {
    
}


+(NSString*) getKey;
+(NSString*) encryptString:(NSString*) string;
+(NSString*) decryptString:(NSString*) string;

+(NSString*) decryptString:(NSString*) string WithKey:(NSString*) key;
+(NSString*) encryptString:(NSString*) string WithKey:(NSString*) key;

+(NSData*) getDecryptDataFromString:(NSString*) string;
+(NSData*) getDecryptDataFromString:(NSString*) string WithKey:(NSString*) key;

+(NSString*) encryptData:(NSData*) data;
+(NSString*) encryptData:(NSData*) data  WithKey:(NSString*) key;


@end
