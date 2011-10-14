
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>  
#import "standard_iphone_appDelegate.h"
#import "ComplexTableCell.h"
#import "ComplexTableSection.h"
#import "ComplexTableView.h"
#import "DBModel.h"
#import "AppSettingsManager.h"

#define Pad UIUserInterfaceIdiomPad 
#define Phone UIUserInterfaceIdiomPhone 
#define DeviceType [[UIDevice currentDevice] userInterfaceIdiom]

#define CLEAR_OBJ(FIELD) [FIELD release]; FIELD = nil;