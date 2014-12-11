//
//  BackgroundOperations.m
//  VITCloud
//
//  Created by Siddharth Gupta on 12/10/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "BackgroundOperations.h"

@implementation BackgroundOperations

+ (id)singleton {
    
    static BackgroundOperations *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.allFiles = [[NSMutableArray alloc] init];
    });
    return sharedMyManager;
}

-(void)beginScanning{
    NSLog(@"Starting: %@", [self.allFiles description]);
    NSArray *keys = @[@"textDownloads", @"textMovies", @"textTVSeries", @"textDocumentaries" ];
    for (NSString *key in keys){
        if([[NSUserDefaults standardUserDefaults] URLForKey:key]){
            [self scanForFilesAtPath:[[NSUserDefaults standardUserDefaults] URLForKey:key]];
        }
    }
    NSLog(@"After Scanning: %@", [self.allFiles description]);
    
}

-(void)scanForFilesAtPath:(NSURL *)path{
    //NSLog(@"Currently array is: %@", [self.allFiles description]);
    //NSLog(@"Scan Run on URL: %@", [path description]);
    
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:path includingPropertiesForKeys:@[NSFileSize, NSFileType] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    NSLog(@"Scanned Directory: %@", [dirs description]);
    
    static unsigned long long int fileSize;
    
    for (NSURL *file in dirs){
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath: [file path] error: NULL];
        NSLog(@"%@", [file lastPathComponent]);
        fileSize = [attrs fileSize];
        
        if(fileSize > 100000000){
            [self.allFiles addObject:[file lastPathComponent]];
            [self.allFiles addObject:[NSString stringWithFormat:@"%llu", fileSize]];
        }
        
        
    }
}

@end
