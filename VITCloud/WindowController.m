//
//  WindowController.m
//  VITCloud
//
//  Created by Siddharth Gupta on 12/9/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "WindowController.h"

@implementation WindowController

- (IBAction)folder1ButtonClicked:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setCanCreateDirectories:NO];
    
    if ( [panel runModal] == NSOKButton )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSArray* files = [panel URLs];
        
        // Loop through all the files and process them.
        
        NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:files[0] includingPropertiesForKeys:@[NSFileSize, NSFileType] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
        
        NSLog(@"%@", [dirs description]);
        
        for (NSURL *file in dirs){
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath: [file path] error: NULL];
            NSLog(@"%@", [file lastPathComponent]);
            NSLog(@"%llu MB", (([attrs fileSize]/1000)/1000));
        }
    }
}
@end
