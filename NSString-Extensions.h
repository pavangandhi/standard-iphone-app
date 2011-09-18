//
//  NSString-Extensions.h
//  weltrekorde
//
//  Created by Alexander Herbel on 05.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_Extensions)
+ (id)objectWithSqlColumnRepresentation:(NSString *)columnData;
- (NSString *)sqlColumnRepresentationOfSelf;
- (BOOL) isNotEmpty;
- (BOOL) containsString: (NSString*) substring;
- (NSString *) MD5;
- (NSData*) stringToData;
- (NSString*)nl2br;
- (NSString *) trimmedString;
- (NSDate *) date;

@end
