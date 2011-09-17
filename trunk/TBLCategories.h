//
//  TBLCategories.h
//  weltrekorde
//
//  Created by Alexander Herbel on 31.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBModel.h"

@interface TBLCategories : DBModel {
    NSString *categorieName;
    NSDate *createdAt;
    NSString *asdf;
}

@property (nonatomic,retain) NSString *categorieName;
@property (nonatomic,retain) NSDate *createdAt;
@property (nonatomic,retain)  NSString *asdf;

+(NSArray *)indices;

@end
