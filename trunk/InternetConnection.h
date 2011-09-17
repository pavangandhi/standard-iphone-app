//
//  InternetConnection.m
//  RedCarper
//
//  Created by Alexander Herbel on 07.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>

@interface InternetConnection : NSObject {
    
}

+ (BOOL) hasInternet;
+ (BOOL) connectedToWiFi;


@end