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
        sharedMyManager.supportedExtensions = @[@"mp4", @"mkv", @"avi", @"iso", @"mp3", @"xvid", @"divx"];
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
    NSLog(@"After Scanning: %@", [self.allFiles description]);
    
}

-(void)scanForFilesAtPath:(NSURL *)path{
    
    static unsigned long long int fileSize;
    
    NSURL* file;
    NSDirectoryEnumerator* enumerator = [[NSFileManager defaultManager] enumeratorAtURL:path includingPropertiesForKeys:@[NSFileSize, NSFileType] options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:^BOOL(NSURL *url, NSError *error) {
        NSLog(@"Error scanning directory: %@", [error description]); //Handles Disconnected Media like external HDD, etc.
        return YES;
    }];
    while (file = [enumerator nextObject])
    {
        // check if it's a directory
        BOOL isDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:[file path] isDirectory:&isDirectory];
        if (!isDirectory)
        {
            // open your file …
            NSError *error;
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath: [file path] error: &error];
            if(!error){
                //NSLog(@"%@", [file lastPathComponent]);
                fileSize = [attrs fileSize];
                
                if([self.supportedExtensions containsObject:[file pathExtension]]){
                    if(fileSize > 100000000){
                        [self.allFiles addObject:[file lastPathComponent]];
                        [self.allFiles addObject:[NSString stringWithFormat:@"%llu", fileSize]];
                        
                    }
                }
            }
            
        }
        else
        {
            [self scanForFilesAtPath: file];
        }
    }
}


@end
