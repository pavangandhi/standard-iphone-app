//
//  Database.h
//  standard-iphone-app
//
//  Created by Alexander on 17.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface Database : NSObject {
	NSString *pathToDatabase;
	BOOL debugging;
	sqlite3 *database;
    NSMutableArray *checkedTables;
	BOOL syncMode;
}

+ (Database *)sharedManager;
- (void) close;
- (sqlite3*) getSqliteDatabase;
- (BOOL) executeUpdateQuery:(NSString*) s_query;
- (BOOL) tableExists:(NSString *)tableName;
- (BOOL) didCheckTable:(NSString*)tableName;
- (void) addCheckedTable:(NSString*)tableName;
- (void) open;
- (void) setDebugMode:(BOOL) yesNo;
- (BOOL) getDebugMode;
- (void) setSyncMode:(BOOL) yesNo;
- (BOOL) getSyncMode;

@end
