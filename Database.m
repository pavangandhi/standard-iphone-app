//
//  Database.m
//  standard-iphone-app
//
//  Created by Alexander on 17.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Database.h"

@interface Database(PrivateMethods)
- (void) initDatabase;
- (void) checkAllTables;
@end

@implementation Database

/**
 * Creates a singleton instance
 *
 * @return AppSettingsManger instance
 */

static Database *databaseManager = nil;

+ (Database *)sharedManager {
	
	if (databaseManager == nil) {
		databaseManager = [[super allocWithZone:NULL] init];
	}
	
	return databaseManager;
}


+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedManager] retain];
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////// SINGLETON END /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


#pragma mark -



/*
 Öffnet eine Datenbank
 */

- (void) open
{
	[self initDatabase];
	[self checkAllTables];		
	
	NSString *filename = @"database.sqlite";
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	pathToDatabase = [[NSString alloc] initWithFormat:@"%@",[[paths objectAtIndex:0] stringByAppendingPathComponent:filename]];
	checkedTables = [[NSMutableArray alloc] init];
	
	if(debugging == TRUE) {
		NSLog(@"Database-filepath: %@",pathToDatabase);
	}
    
	int result = sqlite3_open([pathToDatabase cStringUsingEncoding:NSUTF8StringEncoding], &database);
	
	if(result == SQLITE_OK) {
		if(debugging == TRUE) {
			NSLog(@"SUCESS: open database");
		}
	}
    
	if(debugging == TRUE) {
		NSLog(@"ERROR: open database");
	}
}


-(void) setDebugMode:(BOOL) yesNo {
	debugging = yesNo;
}

-(BOOL) getDebugMode {
	return debugging;
}

-(void) setSyncMode:(BOOL) yesNo {
	syncMode = yesNo;
}

-(BOOL) getSyncMode {
	return syncMode;
}


/*
 Gibt die aktuelle Datenbank zurück
 */

-(sqlite3*) getSqliteDatabase {
    return database;
}






/*
 Schließt die aktuelle Datenbank
 */

- (void) close
{
	if(sqlite3_close(database) == SQLITE_OK)
	{
		if(debugging == TRUE) {
			NSLog(@"SUCESS: close database");
		}
	} 
	
	if(debugging == TRUE) {
		NSLog(@"ERROR: close database");
	}
}





/*
 Führt eine SQL-Anweisung aus und liefert einen boolischen Wert zurück
 */

-(BOOL) executeUpdateQuery:(NSString*) s_query {
	if (sqlite3_exec (database, [s_query UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
        return FALSE;
    }
    return TRUE;
}





/*
 Führt notwendige SQL-Anweisungen aus
 */

-(void) initDatabase {
    [self executeUpdateQuery:@"PRAGMA encoding = \"UTF-8\""];
    [self executeUpdateQuery:@"PRAGMA auto_vacuum=1"];
    [self executeUpdateQuery:@"PRAGMA CACHE_SIZE=0"];      
}





/*
 Prüft ob Tabellen in der Datenbank korrupt sind, wenn ja, werden diese repariert
 */

- (void)checkAllTables
{
    NSString *updateSQL = @"pragma integrity_check";
    sqlite3_stmt *xLoopStmt;
    if (sqlite3_prepare_v2( database, [updateSQL UTF8String], -1, &xLoopStmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(xLoopStmt) == SQLITE_ROW)
        {
            const char *columnText = (const char *)sqlite3_column_text(xLoopStmt,0);
            NSString *string = [NSString stringWithUTF8String:columnText];
            NSRange range = [string rangeOfString : @"TBL"];
            
            if (range.location != NSNotFound)
            {
                NSString *index = [string substringFromIndex:range.location ];
                NSString *dropSQL = [NSString stringWithFormat:@"REINDEX %@;",index];
                
                if([self executeUpdateQuery:dropSQL] == YES) {
                    if(debugging == TRUE) {
                        NSLog(@"SUCCESS: REINDEX TABLE: %@",index);
                    }
                } else {
                    if(debugging == TRUE) {
                        NSLog(@"ERROR: REINDEXED TABLE: %@",index);
                    }
                }
            }
        }
    }
    sqlite3_finalize(xLoopStmt);   
}






/*
 Fügt den String einer Tabelle zu den geprüften Tabellen in Array hinzu
 */

-(void) addCheckedTable:(NSString*)tableName {
    [checkedTables addObject:tableName];
}





/*
 Prüft ob eine Tabelle bereits geprüft ist
 */

-(BOOL) didCheckTable:(NSString*)tableName {
    return [checkedTables containsObject:tableName];
}





/*
 Prüft ob eine Tabelle existiert
 */

- (BOOL)tableExists:(NSString *)tableName
{
	BOOL ret = NO;
	NSString *query = [NSString stringWithFormat:@"pragma table_info(%@);", tableName];
	sqlite3_stmt *stmt;
	if (sqlite3_prepare_v2(database,  [query UTF8String], -1, &stmt, nil) == SQLITE_OK) {
		if (sqlite3_step(stmt) == SQLITE_ROW)
			ret = YES;
		sqlite3_finalize(stmt);
	}
	return ret;
}



/** 
 Durchsucht Datenbank nach übergebene SQL-Anweisung und gibt die Daten in einem Array zurück
*/



-(NSArray*) findByQuery:(NSString*) query {
	NSMutableArray *ret = [NSMutableArray array];
	
	sqlite3_stmt *statement;
	
	int i = 0;
	if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{
		while (sqlite3_step(statement) == SQLITE_ROW) {
			id oneItem = [[[[self class] alloc] init] autorelease];
			
			for (i=0; i <  sqlite3_column_count(statement); i++)
			{
				NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(statement, i)];
                id colData = nil;
                const char *columnText = (const char *)sqlite3_column_text(statement, i);
				
                if (NULL != columnText) {
                    colData = [NSString stringWithUTF8String:columnText];
                }
				
                free((void*)columnText);
				
                [oneItem setValue:colData forKey:columnName];
			}
			
			[ret addObject:oneItem];
		}
	} else {
        sqlite3_finalize(statement);
        if(debugging == YES) {
            NSLog(@"ERROR selection data %@",query);
		}
        return nil;
	}
    
    if(debugging == YES) {
        NSLog(@"SUCCESS: selecting data - count: %i - SQL: %@",[ret count],query);
    }
    
	sqlite3_finalize(statement);
	
	if([ret count] == 0) return nil;
	
	return ret;
}





@end
