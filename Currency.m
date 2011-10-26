//
//  Currency.m
//  standard-iphone-app
//
//  Created by Per Hlawatschek on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Currency.h"

#define APP_CURRENCY_LOCALE @"_app_currency_locale"

@implementation Currency

/*
 
 -(void) openChooseCurrencyView {
 
 NSArray *a_currencies = [AppValues getCurrencies];
 NSMutableArray *a_data = [[NSMutableArray alloc] init];
 
 
 for(int x = 0; x < [a_currencies count]; x++) {
 NSMutableDictionary *dict = [a_currencies objectAtIndex:x];
 ListSelectionArrayType *singleSelection = [[ListSelectionArrayType alloc] init];
 singleSelection.s_labelText = [dict valueForKey:@"countryName"];
 singleSelection.s_detailText = [NSString stringWithFormat:@"Währung: %@",[dict valueForKey:@"currencySymbol"]];
 singleSelection.s_returnValue = [dict valueForKey:@"localeIdentifier"];
 [a_data addObject:singleSelection];
 CLEAR_OBJ(singleSelection);
 }
 
 ListSelection *newList = [ListSelection new];
 newList.a_listSelectionArray = a_data;
 newList.s_table_header_string = @"Wähle das Land deiner Währung";
 newList.addStandardSearchbar = YES;
 newList.s_selected_value = @"de_DE";
 newList.searchInTextLabel = YES;
 newList.searchInDetailLabel = YES;
 newList.s_rightNavigationButtonTitle = @"Wählen";
 newList.s_navigation_title = @"Währung auswählen";
 newList.returnDelegate = self;
 newList.returnValuesSelector = @selector(saveAppCurrency:);
 [self.navigationController pushViewController:newList animated:YES];
 } 
 
*/



+(NSArray*) getCurrencies {
    
    NSLocale *appLanguageLocale = [[NSLocale alloc] initWithLocaleIdentifier:[NSLocale currentLocale]];
    NSArray *allAvailableLocales = [NSLocale availableLocaleIdentifiers];
    
    NSMutableArray *a_locales = [NSMutableArray array];
    NSMutableArray *a_currencies = [NSMutableArray array];
    NSMutableArray *a_tmp = [NSMutableArray array];
    
    for(int x = 0; x < [allAvailableLocales count];x++) {
        NSRange range = [[allAvailableLocales objectAtIndex:x] rangeOfString:@"_"];
        if(range.location != NSNotFound){
            NSArray *a_dashes = [[allAvailableLocales objectAtIndex:x] componentsSeparatedByString:@"_"];
            if([a_dashes count]==2) {
                
                NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[allAvailableLocales objectAtIndex:x]];
                NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
                
                NSString *countryName = [appLanguageLocale displayNameForKey:NSLocaleCountryCode value:countryCode];
                NSString *currencySymbol = [locale objectForKey:NSLocaleCurrencySymbol];
                NSString *currencyCode = [locale objectForKey:NSLocaleCurrencyCode];
                NSString *localeIdentifier = [allAvailableLocales objectAtIndex:x];
                
                NSMutableDictionary *localeData = [NSMutableDictionary dictionary];
                [localeData setValue:countryName forKey:@"countryName"];
                [localeData setValue:currencySymbol forKey:@"currencySymbol"];
                [localeData setValue:currencyCode forKey:@"currencyCode"];
                [localeData setValue:localeIdentifier forKey:@"localeIdentifier"];
                
                if([a_currencies containsObject:countryName]==FALSE && countryName != nil && [currencySymbol length]>0) {
                    [a_currencies addObject:countryName];
                    [a_tmp addObject:currencySymbol];
                    [a_locales addObject:localeData];
                } else {
                    if([a_tmp containsObject:currencySymbol]==FALSE && countryName != nil && [currencySymbol length]>0) {
                        [a_tmp addObject:currencySymbol];
                        [a_locales addObject:localeData];
                    }
                }
            }
        }
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"countryName"  ascending:YES];
    [a_locales sortUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    return a_locales;
}




+(NSString*) stringFromNumber:(NSNumber*) number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]  init];
    [formatter setLocale:[self getAppCurrencyLocale]];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *sNumber = [formatter stringFromNumber:number];
    [formatter release];
    return sNumber;
}

+(NSString*) stringFromFloat:(float) floatNumber {
    NSNumber *number = [NSNumber numberWithFloat:floatNumber];
    return [self stringFromNumber:number];
}


+(NSNumber*) numberFromString:(NSString*) stringNumber {
    NSNumberFormatter * formatter= [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber* myNumber = [formatter numberFromString:stringNumber];
    [formatter release];
    return myNumber;
}


+(float) floatFromString:(NSString*) stringNumber {
    return [[self numberFromString:stringNumber] floatValue];
}



+(BOOL) setAppCurrencyLocale:(NSString*)currencyLocale {
	return [UserDefaults setString:currencyLocale forKey:APP_CURRENCY_LOCALE];
}

+(NSLocale*) getAppCurrencyLocale {
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:[UserDefaults getStringForKey:APP_CURRENCY_LOCALE]] autorelease]; 
	return locale;
}





@end
