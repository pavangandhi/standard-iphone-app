//
//  Currency.h
//  standard-iphone-app
//
//  Created by Per Hlawatschek on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject


+(NSArray*) getCurrencies;
+(NSString*) stringFromNumber:(NSNumber*) number;
+(NSString*) stringFromFloat:(float) floatNumber;
+(BOOL) setAppCurrencyLocale:(NSString*)currencyLocale;
+(NSLocale*) getAppCurrencyLocale;

+(NSNumber*) numberFromString:(NSString*) stringNumber;
+(float) floatFromString:(NSString*) stringNumber;
@end
