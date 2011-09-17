//
//  InternetConnection.m
//  RedCarper
//
//  Created by Alexander Herbel on 07.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "InternetConnection.h"
#import "Reachability.h"

@implementation InternetConnection

// Function: function to that checks if the the device is connected to the internet
// Return: a boolean Value (yes = connected;   no = not connected)

+ (BOOL) hasInternet {  
    
    // Create zero addy  
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    NSURL *testURL = [NSURL URLWithString:@"http://www.google.de/imghp?hl=de&tab=wi"];
    
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSURLConnection *testConnection = [[[NSURLConnection alloc] initWithRequest:testRequest delegate:self] autorelease];
    
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}


// Function: function to that checks if the the device is connected to the wifi
// Return: a boolean Value (yes = connected;   no = not connected)

+(BOOL)connectedToWiFi
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];  
    
    BOOL result = FALSE;
    
    if (internetStatus == ReachableViaWiFi)
        result = TRUE;     
    
    return result;
}

- (void)dealloc {
    [super dealloc];
}

@end