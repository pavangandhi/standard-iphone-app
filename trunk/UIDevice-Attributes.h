//
//  UIDevice-Attributes.h
//  RedCarper
//
//  Created by Alexander Herbel on 07.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIDevice (UIDevice_Attributes)

+ (NSString*) getHardwareDeviceName;
+ (BOOL) hasDeviceGPS;
+ (BOOL) hasDeviceRearCamera;
+ (BOOL) hasDeviceFrontCamera;
@end
