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
    });
    return sharedMyManager;
}

-(void)beginScanning{
    NSArray *keys = @[@"textDownloads", @"textMovies", @"textTVSeries", @"textDocumentaries" ];
    for (NSString *key in keys){
        if([[NSUserDefaults standardUserDefaults] URLForKey:key]){
            [self scanForFilesAtPath:[[NSUserDefaults standardUserDefaults] URLForKey:key]];
        }
    }
}

-(void)scanForFilesAtPath:(NSURL *)path{
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:path includingPropertiesForKeys:@[NSFileSize, NSFileType] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    NSLog(@"Scanned Directory: %@", [dirs description]);
    
    
    for (NSURL *file in dirs){
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath: [file path] error: NULL];
        NSLog(@"%@", [file lastPathComponent]);
        NSLog(@"%llu MB", (([attrs fileSize]/1000)/1000));
    }
}

@end
