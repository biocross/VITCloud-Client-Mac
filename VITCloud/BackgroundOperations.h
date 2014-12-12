//
//  BackgroundOperations.h
//  VITCloud
//
//  Created by Siddharth Gupta on 12/10/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface BackgroundOperations : NSObject 


+ (id)singleton;
@property NSMutableArray *allFiles;
-(void)beginScanning;
@property NSArray *supportedExtensions;

@property NSError *error;
@property NSURLResponse *response;

@end
