//
//  NSString-Extensions.m
//  weltrekorde
//
//  Created by Alexander Herbel on 05.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString-Extensions.h"


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
    
};


@end
