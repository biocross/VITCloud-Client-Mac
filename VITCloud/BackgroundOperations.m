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
    //Clear data before rescanning:
    self.allFiles = nil;
    self.allFiles = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [appDelegate setStatus:@"Scanning"];
    [appDelegate setStatusIconProgress:YES];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("fileScanner", nil);
    dispatch_async(downloadQueue, ^{
    
            NSArray *keys = @[@"textDownloads", @"textMovies", @"textTVSeries", @"textDocumentaries" ];
            for (NSString *key in keys){
                if([[NSUserDefaults standardUserDefaults] URLForKey:key]){
                    [self scanForFilesAtPath:[[NSUserDefaults standardUserDefaults] URLForKey:key]];
                }
            }
    
        dispatch_async(dispatch_get_main_queue(), ^{});

        NSLog(@"After Scanning: %@", [self.allFiles description]);
        //Call Uploader Here.
        [self prepareForUpload];
        
    });

}

-(void)prepareForUpload{
    NSMutableDictionary *POSTData = [[NSMutableDictionary alloc] init];
    [POSTData setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"textBlock"] forKey:@"Block"];
    [POSTData setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"textRoom"] forKey:@"Room"];
    [POSTData setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"textHostel"] forKey:@"Hostel"];
    
    
    [POSTData setValue:self.allFiles forKey:@"Files"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [appDelegate setStatus:@"Uploading"];
    
    BOOL internetConnected = NO;
    //Check if internet reachable
    NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com/m"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data){
        NSLog(@"Device is connected to the internet");
        internetConnected = YES;
    }
    else{
        NSLog(@"Device is not connected to the internet");
    }
    
    
    if(!internetConnected){
        NSLog(@"No Internet Connection");
        [appDelegate setStatus:@"No Internet Connection"];
        [appDelegate setStatusIconProgress:NO];
        return;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:POSTData options:0 error:nil];
    NSLog(@"Sending JSON Object: %@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

    dispatch_queue_t downloadQueue = dispatch_queue_create("jsonUploader", nil);
    dispatch_async(downloadQueue, ^{
        
        NSLog(@"Started Request");
        NSURL *url = [NSURL URLWithString:@"http://localhost:8000/interface"];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        NSError *error = nil;
        NSURLResponse *response = nil;
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:jsonData];
        [NSURLConnection sendSynchronousRequest:request
                              returningResponse:&response
                                          error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{});
        
            if(error){
                NSLog(@"Error: %@", [error localizedDescription]);
            }
            else{
                NSInteger httpCode = [(NSHTTPURLResponse *)response statusCode];
                
                if(!httpCode){
                    NSLog(@"No Response Code Recieved");
                }
                else{
                    NSLog(@"Request seems to be successful with response code: %ld", (long)httpCode);
                }
            }
        
        [appDelegate setStatus:@"Index Upload Complete"];
        [appDelegate setStatusIconProgress:NO];
    });
    
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
