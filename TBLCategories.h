//
//  TBLCategories.h
//  weltrekorde
//
//  Created by Alexander Herbel on 31.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TBLCategories : DBModel {
    NSString *categorieName;
    NSString *asdf;
	NSDate *kaufdatum;
	int anzahl;
	float preis;
}

@property (nonatomic,retain) NSString *categorieName;
@property (nonatomic,retain) NSString *asdf;
@property (nonatomic,retain) NSDate *kaufdatum;
@property (nonatomic) int anzahl;
@property (nonatomic) float preis;

+(NSArray *)indices;

@end
