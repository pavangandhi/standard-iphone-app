//
//  DBModel.m
//  meinInventar
//
//  Created by Alexander on 12.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DBModel.h"

@interface DBModel(PrivateMethods)
+ (NSString *) tableName;
+ (sqlite3*) getDatabase;
- (long long) generateKey;
+ (NSArray *)tableColumns;
- (void) checkTable;
+ (NSDictionary *)propertiesWithEncodedTypes;
- (BOOL) createTable;
- (BOOL) alterTable;
+ (BOOL) executeUpdateQuery:(NSString*) s_query;
-(void) createIndizes;
@end


@implementation DBModel
@synthesize pk;
@synthesize createdAt;
@synthesize updatedAt;
@synthesize crud;

- (id) init
{
	if(self == [super init])
	{
        debugging = [[Database sharedManager] getDebugMode];
        [self checkTable];
		pk = -1;
		
	}
	
	return self;
}


+(sqlite3*) getDatabase {
    return [[Database sharedManager] getSqliteDatabase];
}

-(void) checkTable {

    // Prüfe ob jetzige Tabelle bereits geprüft wurde
    if([[Database sharedManager] didCheckTable:[[self class] tableName]]==TRUE) {
        return;
    } 
    
    // Füge aktuelle Tabelle zu den überprüften Tabellen hinzu
    [[Database sharedManager] addCheckedTable:[[self class] tableName]];
    
    // Wenn Tabelle nicht existiert, dann erstelle eine Tabelle
    if([[Database sharedManager] tableExists:[[self class] tableName]] == FALSE) {
        [self createTable];
        [self createIndizes];
    }
    // Wenn Tabelle existiert, dann prüfe, ob Tabelle erweitert werden soll
    else
    {
        [self alterTable];
    }
}


-(BOOL) alterTable {
    NSArray *tableColumns = [[self class] tableColumns];
    NSDictionary *theProps = [[self class]  propertiesWithEncodedTypes];
    
    for (NSString *oneProp in theProps) {
        if(![tableColumns containsObject:oneProp]) {
            NSMutableString *executeSQL = [NSMutableString stringWithFormat:@"alter table %@ add column %@ ", [[self class] tableName], oneProp];
            
            NSString *propType = [[[self class] propertiesWithEncodedTypes] objectForKey:oneProp];
            
            if ([propType isEqualToString:@"i"] || [propType isEqualToString:@"ll"]) {
                [executeSQL appendFormat:@"INTEGER"];            
            }      
            else if ([propType isEqualToString:@"f"])
            {                
                [executeSQL appendFormat:@"REAL"];
            }
            else if ([propType hasPrefix:@"@"]) // Object
            {
                [executeSQL appendFormat:@"TEXT"];
            }
            
            
            if([[self class] executeUpdateQuery:executeSQL] == FALSE) {
                if(debugging == YES) {
                    NSLog(@"ERROR: alter table: %@, SQL: %@", [self class],executeSQL);
                    return FALSE;
                }
            } else {
                if(debugging == YES) {
                    NSLog(@"SUCCESS: alter table: %@, SQL: %@", [self class],executeSQL);
                }                
            }
        }
    }
    
    return TRUE;
}



-(BOOL) createTable {
    NSDictionary *theProps = [[self class]  propertiesWithEncodedTypes];
    NSMutableString *createSQL = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (pk INTEGER PRIMARY KEY",[[self class] tableName]];
    

	
    for (NSString *oneProp in theProps)
    {
        NSString *propName = oneProp;
        NSString *propType = [[[self class] propertiesWithEncodedTypes] objectForKey:oneProp];
        if ([propType isEqualToString:@"i"] || [propType isEqualToString:@"ll"]) {
            [createSQL appendFormat:@", %@ INTEGER", oneProp];            
        }      
        else if ([propType isEqualToString:@"f"])
        {                
            [createSQL appendFormat:@", %@ REAL", oneProp];
        }
        else if ([propType hasPrefix:@"@"]) // Object
        {
            [createSQL appendFormat:@", %@ TEXT", propName];
        }
    }        
    
    [createSQL appendString:@")"];
    
    // Führe Query aus
    if([[self class] executeUpdateQuery:createSQL] == FALSE) {
        if(debugging == YES) {
            NSLog(@"ERROR: creating table: %@, SQL: %@", [self class],createSQL);
            return FALSE;
        }
    } else {
        if(debugging == YES) {
            NSLog(@"SUCCESS: creating table: %@, SQL: %@", [self class],createSQL);
        }
    }
    
    return TRUE;
}


-(void) createIndizes {
    NSArray *theIndices = [[self class] indices];
    if (theIndices != nil)
    {
        if ([theIndices count] > 0)
        {
            for (NSArray *oneIndex in theIndices)
            {
                NSMutableString *indexName = [NSMutableString stringWithString:[[self class] tableName]];
                NSMutableString *fieldCondition = [NSMutableString string];
                BOOL first = YES;
                for (NSString *oneField in oneIndex)
                {
                    [indexName appendFormat:@"_%@", oneField];
                    
                    if (first)
                        first = NO;
                    else
                        [fieldCondition appendString:@", "];
                    [fieldCondition appendString:oneField];
                }
                NSString *indexQuery = [NSString stringWithFormat:@"create index if not exists %@ on %@ (%@)", indexName, [[self class] tableName], fieldCondition];
                
                if([[self class] executeUpdateQuery:indexQuery] == FALSE) {
                    NSLog(@"ERROR: create index on table: %@ => SQL: %@", [self class],indexQuery);
                    
                } else {
                    NSLog(@"SUCCESS: create index on table: %@ => SQL: %@", [self class],indexQuery);              
                }
            }
        }
    }

}




+(BOOL) executeUpdateQuery:(NSString*) s_query {
	if (sqlite3_exec ([[self class] getDatabase], [s_query UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
        return FALSE;
    }
    return TRUE;
}

+ (NSString *) tableName
{
	return NSStringFromClass([self class]);
}


-(NSInteger) countRowsByCriteria:(NSString*)criteria {

    NSInteger countOfRecords = 0;
    NSString *countQuery = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ %@", [[self class] tableName], criteria];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2([[self class] getDatabase], [countQuery UTF8String], -1, &statement, nil) == SQLITE_OK) 
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            countOfRecords = sqlite3_column_int(statement, 0);
		}
		if(debugging == TRUE) {
			NSLog(@"SUCCESS: countRows - Rows count: %i\nSQL: %@", countOfRecords,countQuery);		
		}
    } 
    else {
		if(debugging == TRUE) {
			NSLog(@"ERROR: countRows\nSQL: %@", [[self class] tableName]);		
		}
		countOfRecords = -1;
	} 
	
    sqlite3_finalize(statement);
    return countOfRecords;
}



+(NSArray *)tableColumns
{
    NSMutableArray *ret = [NSMutableArray array];

    NSString *query = [NSString stringWithFormat:@"pragma table_info(%@);", [self tableName]];
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2( [[self class] getDatabase],  [query UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            const unsigned char *colName = sqlite3_column_text(stmt, 1);
            NSString *colString = [NSString stringWithUTF8String:(const char *)colName];
            [ret addObject:colString];
        }
        
        sqlite3_finalize(stmt);
    }
	
    return ret;
}



+(id)findByPK:(long long)inPk {
	NSArray *object = [[self class] findByQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE pk = %lld LIMIT 1", [[self class] tableName], inPk]];

	if (object != nil) {
		return [object objectAtIndex:0];
	} 
	
	return nil;
}


+(id) findFirstByQuery:(NSString*) query {
	NSArray *ret = [self findByQuery:query];
	if(ret != nil) {
		return [ret objectAtIndex:0];
	}
	return nil;
}

+ (id) findFirstByCriteria:(NSString*) criteria {
	NSArray *ret = [[self class] findByCriteria:criteria];
	if(ret != nil) {
		return [ret objectAtIndex:0];
	}
	return nil;	
}


+(id) findByCriteria:(NSString*) criteria {
	NSArray *array =  [self findByQuery:[NSString stringWithFormat:@"SELECT * FROM %@ %@",[[self class] tableName],criteria]];
	NSLog(@"array: %@", array);
	return array;
}


+(NSArray*) findByQuery:(NSString*) query {
	NSMutableArray *ret = [NSMutableArray array];
	NSDictionary *theProps = [[self class] propertiesWithEncodedTypes];

	// füge die fehlenden Fehler hinzu
	[theProps setValue:@"ll" forKey:@"pk"];	
	
	sqlite3_stmt *statement;
	
	int i = 0;
	if (sqlite3_prepare_v2( [[self class] getDatabase], [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{
		while (sqlite3_step(statement) == SQLITE_ROW) {
			id oneItem = [[[[self class] alloc] init] autorelease];
			
			for (i=0; i <  sqlite3_column_count(statement); i++)
			{
				NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(statement, i)];
				NSString *colType = [theProps valueForKey:columnName];

				if ([colType isEqualToString:@"i"] || [colType isEqualToString:@"ll"]) 
				{
					long long value = sqlite3_column_int64(statement, i);
					NSNumber *colValue = [NSNumber numberWithLongLong:value];
					[oneItem setValue:colValue forKey:columnName];
				}
				else if ([colType isEqualToString:@"f"])
				{
					NSNumber *colVal = [NSNumber numberWithFloat:sqlite3_column_double(statement, i)];
					[oneItem setValue:colVal forKey:columnName];
				}
				else if ([colType hasPrefix:@"@"])
				{
					NSString *className = [colType substringWithRange:NSMakeRange(2, [colType length]-3)];
					Class propClass = objc_lookUpClass([className UTF8String]);
					
					id colData = nil;
					const char *columnText = (const char *)sqlite3_column_text(statement, i);

					if (NULL != columnText) {
						colData = [propClass objectWithSqlColumnRepresentation:[NSString stringWithUTF8String:columnText]];
					} else {
						free((void*)columnText);
					}

					[oneItem setValue:colData forKey:columnName];
				}
			}
			
			[ret addObject:oneItem];
		}
	} else {
			sqlite3_finalize(statement);
			NSLog(@"ERROR selection data %@",query);
		return nil;
	}

    
    NSLog(@"SUCCESS: selecting data - count: %i - SQL: %@",[ret count],query);
	sqlite3_finalize(statement);
	
	if([ret count] == 0) return nil;
	
	return ret;
}



-(BOOL) delete {
	if(pk < 0) return FALSE;

	NSString *deleteQuery = @"";

	if([crud isEqualToString:syncCreate] || [[Database sharedManager] getSyncMode] == FALSE) {
		deleteQuery = [NSString stringWithFormat:@"DELETE FROM %@ WHERE pk = %lld", [[self class] tableName], pk];		
	} else {
		deleteQuery = [NSString stringWithFormat:@"UPDATE %@ SET crud = '%@' WHERE pk = %lld", [[self class] tableName], syncDelete, pk];			
	}
	
	if (sqlite3_exec ([[self class] getDatabase], [deleteQuery UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
		
		if(debugging == TRUE) {
			NSLog(@"ERROR: deleting row with PK: %lld in table: %@", pk, [[self class] tableName]);
		}
	
		return FALSE;
	}
	
	if(debugging == TRUE) {
		NSLog(@"SUCESS: deleting row with PK: %lld in table: %@", pk, [[self class] tableName]);
	}

	return TRUE;
}



-(long long) generateKey {
//	NSString *timestamp = [NSString stringWithFormat:@"%d", (long)[[NSDate date] timeIntervalSince1970]];
	
	int min = 1;
	long long max = 123; // 9223372036854755807
	int random = (arc4random() % (max - min)) + min;

	return random;
}



-(BOOL) save {
    BOOL ret = FALSE;
    
	NSLog(@"created at: %@",createdAt);
	NSLog(@"pk: %lld", pk);
	
	if (saved) {
		return saved;
	}
	saved = YES;
	
	if (pk < 0)
    {
		pk = [self generateKey];
		createdAt = [NSDate date];
		updatedAt = [NSDate date];
		if([[Database sharedManager] getSyncMode] == TRUE) {
			crud = syncCreate;
		}
    } else {
		updatedAt = [NSDate date];
		if([[Database sharedManager] getSyncMode] == TRUE) {
			if([crud isEqualToString:syncNULL]) {
				crud = syncUpdate;
			}
		}
	}


	NSMutableString *updateSQL = [NSMutableString stringWithFormat:@"INSERT OR REPLACE INTO %@ (pk", [[self class] tableName]];
	NSMutableString *bindSQL = [NSMutableString string];
	
	NSDictionary *props = [[self class] propertiesWithEncodedTypes];
	for (NSString *propName in props)
	{
		[updateSQL appendFormat:@", %@", propName];
		[bindSQL appendString:@", ?"];
	}

	[updateSQL appendFormat:@") VALUES (?%@)", bindSQL];		
	
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2([[self class] getDatabase], [updateSQL UTF8String], -1, &stmt, nil);
	
    if(result == SQLITE_OK) {
    
        int colIndex = 1;
        sqlite3_bind_int(stmt, colIndex++, pk);
        
        props = [[self class] propertiesWithEncodedTypes];
        for (NSString *propName in props)
        {
            NSString *propType = [props objectForKey:propName];

            id theProperty = [self valueForKey:propName];

            if ([propType isEqualToString:@"i"])
            {
                sqlite3_bind_int(stmt, colIndex++, [theProperty intValue]);
            }
            else if ([propType isEqualToString:@"f"])
            {
				sqlite3_bind_text(stmt, colIndex++, [[theProperty stringValue] UTF8String], -1, NULL);
            }   			
            else if ([propType hasPrefix:@"@"])
            {
                sqlite3_bind_text(stmt, colIndex++, [[theProperty sqlColumnRepresentationOfSelf] UTF8String], -1, NULL);
            }   
        }
    }

	if (sqlite3_step(stmt) == SQLITE_DONE)
	{	
		if(debugging == YES) {
			NSLog(@"SUCCESS: saving object: %@\nSQL:%@",[self class],updateSQL);
		}
		ret = TRUE;
	} else {
        if(debugging == YES)  {
            NSLog(@"ERROR: saving object: %@\nSQL:%@",[self class],updateSQL);
        }
        ret = FALSE;
    }
    
	sqlite3_finalize(stmt);
    return ret;
}



+(NSDictionary *)propertiesWithEncodedTypes
{
	NSMutableDictionary *theProps = [NSMutableDictionary dictionary];
	
	unsigned int outCount;
	int i;
    
	objc_property_t *propList = class_copyPropertyList([self class], &outCount);

	for (i=0; i < outCount; i++)
	{
		objc_property_t oneProp = propList[i];
		NSString *propName = [NSString stringWithUTF8String:property_getName(oneProp)];
		NSString *attrs = [NSString stringWithUTF8String: property_getAttributes(oneProp)];
        
		if ([attrs rangeOfString:@",R,"].location == NSNotFound)
		{
			NSArray *attrParts = [attrs componentsSeparatedByString:@","];
			if (attrParts != nil)
			{
				if ([attrParts count] > 0)
				{
					NSString *propType = [[attrParts objectAtIndex:0] substringFromIndex:1];
					[theProps setObject:propType forKey:propName];
				}
			}
		}
	}

	free( propList );
	
	[theProps setValue:@"@\"NSDate\"" forKey:@"createdAt"];
	[theProps setValue:@"@\"NSDate\"" forKey:@"updatedAt"];	
	
	if([[Database sharedManager] getSyncMode] == TRUE) {
		[theProps setValue:@"@\"NSString\"" forKey:@"crud"];	
	}
	
	return theProps;	
}


+(NSArray *)indices {
    return  nil;
}






@end
