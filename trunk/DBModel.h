//
//  DBModel.h
//  meinInventar
//
//  Created by Alexander on 12.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "standard_iphone_appDelegate.h"
#import "DBConnection.h"
#import "NSDate-Extensions.h"
#import "NSString-Extensions.h"
#import <sqlite3.h>


@interface DBModel : NSObject {
	@public
	long long pk;
	
	@private
	BOOL saved;	
	BOOL debugging;
}


@property (nonatomic) long long pk;

- (BOOL) save;
- (BOOL) delete;
+ (id) findByPK:(int)inPk;
+ (NSArray*) findByCriteria:(NSString*) query;
+ (NSArray *)indices;

@end
