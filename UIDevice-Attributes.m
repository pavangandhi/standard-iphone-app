//
//  UIDevice-Attributes.m
//  RedCarper
//
//  Created by Alexander Herbel on 07.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIDevice-Attributes.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (UIDevice_Attributes)


#pragma mark - getHwardwareDeviceName

/*
 Function: function to get the hardware device name
 Return: a string with the specific hardware name
*/

+ (NSString*) getHardwareDeviceName {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}



#pragma mark - Other Methods

/* 
  Function: a function to check if the device has a camera
 Return: a Boolean value (yes = device has a camera,   no = device has no camera)
*/

+ (BOOL) hasDeviceFrontCamera
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL) hasDeviceRearCamera
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}


/* 
 Function: a function to check if the device has gps
 Return: a Boolean value (yes = device has gps,   no = device has no gps)
 */

+ (BOOL) hasDeviceGPS
{
    NSString *hardwareDeviceName = [self getHardwareDeviceName];
    if ([hardwareDeviceName isEqualToString:@"iPhone2,1"]) return TRUE;       // iPhone 3GS
    if ([hardwareDeviceName isEqualToString:@"iPhone3,1"]) return TRUE;       // iPhone 4G
    if ([hardwareDeviceName isEqualToString:@"iPhone4,1"]) return TRUE;       // iPhone 5G
    
    return FALSE;
}


+ (NSString *)getOSVersionBuild {
    size_t size = 0;    
    NSString *osBuildVersion = nil;
    
	sysctlbyname("kern.osversion", NULL, &size, NULL, 0);
	char *answer = (char*)malloc(size);
	int result = sysctlbyname("kern.osversion", answer, &size, NULL, 0);
    if (result >= 0) {
        osBuildVersion = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    }
    
    return osBuildVersion;   
}



+ (NSString *)deviceIdentifier {
	return [[UIDevice currentDevice] uniqueIdentifier];
}



@end
