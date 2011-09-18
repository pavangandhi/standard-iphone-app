//
//  NSData-Extensions.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (NSData_Extensions)

- (NSData *)AES128MD5EncryptWithKey:(NSString *)key;
- (NSData *)AES128MD5DecryptWithKey:(NSString *)key;
+ (NSData *) dataWithBase64EncodedString:(NSString *) string;
- (id) initWithBase64EncodedString:(NSString *) string;
- (NSData *)zlibInflate;
- (NSData *)zlibDeflate;
- (NSString *) base64Encoding;
- (NSString *) base64EncodingWithLineLength:(NSUInteger) lineLength;

@end


