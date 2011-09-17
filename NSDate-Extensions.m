//
//  NSDate-Extensions.m
//  weltrekorde
//
//  Created by Alexander Herbel on 05.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDate-Extensions.h"


@implementation NSDate (NSDate_Extensions)

+ (id)objectWithSqlColumnRepresentation:(NSString *)columnData;
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:columnData];
}

- (NSString *)sqlColumnRepresentationOfSelf
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:self];
    [dateFormatter release];
    
    return formattedDateString;
}

@end
