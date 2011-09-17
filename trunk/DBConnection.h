//
//  DBConnection.h
//  meinInventar
//
//  Created by Alexander on 12.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <sqlite3.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface DBConnection : NSObject {
	NSString *pathToDatabase;
	BOOL debugging;
	sqlite3 *database;
    NSMutableArray *checkedTables;
}

- (id) init;
- (void) close;
- (sqlite3*) getDatabase;
- (BOOL) executeUpdateQuery:(NSString*) s_query;
- (BOOL) tableExists:(NSString *)tableName;
- (BOOL) didCheckTable:(NSString*)tableName;
- (void) addCheckedTable:(NSString*)tableName;
@end
