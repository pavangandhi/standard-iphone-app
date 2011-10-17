//
//  DBModel.h
//  meinInventar
//
//  Created by Alexander on 12.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"
#import "NSDate-Extensions.h"
#import "NSString-Extensions.h"
#import <sqlite3.h>

#define syncUpdate @"update"
#define syncCreate @"create"
#define syncDelete @"delete"
#define syncNULL @"NULL"

@interface DBModel : NSObject {
	@public
	long long pk;
	NSDate *updatedAt;
	NSDate *createdAt;
	NSString *crud;
	
	@private
	BOOL saved;
	BOOL debugging;
}


@property (nonatomic) long long pk;
@property (nonatomic, retain) NSDate *updatedAt;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSString *crud;

- (BOOL) save;
- (BOOL) delete;
+ (NSArray *)indices;

+ (id) findByPK:(long long)inPk;
+ (id) findFirstByQuery:(NSString*) query;
+ (id) findFirstByCriteria:(NSString*) query;
+ (id) findByCriteria:(NSString*) criteria;
+ (NSArray*) findByQuery:(NSString*) query;

@end
