//
//  NSDate-Extensions.h
//  weltrekorde
//
//  Created by Alexander Herbel on 05.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (NSDate_Extensions)
+ (id)objectWithSqlColumnRepresentation:(NSString *)columnData;
- (NSString *)sqlColumnRepresentationOfSelf;
@end
