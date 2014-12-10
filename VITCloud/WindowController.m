//
//  WindowController.m
//  VITCloud
//
//  Created by Siddharth Gupta on 12/9/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "WindowController.h"

@implementation WindowController

-(void)awakeFromNib{
    NSLog(@"Awake");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *textFields = @[self.textDownloads, self.textMovies, self.textTvSeries, self.textDocumentaries, self.textBlock, self.textHostel, self.textRoomNo];
    
    for(NSTextField *textField in textFields){
        if([defaults stringForKey:textField.identifier]){
            textField.stringValue = [defaults stringForKey:textField.identifier];
        }
        
    }
    
}

- (void)openPanel:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setCanCreateDirectories:NO];
    
    if ( [panel runModal] == NSOKButton )
    {

        NSArray* files = [panel URLs];
        
        NSButton *pressedButton = (NSButton *)sender;
        
        
        if([pressedButton.identifier isEqualToString:@"Downloads"]){
            self.textDownloads.stringValue = files[0];
        }
        else if([pressedButton.identifier isEqualToString:@"Movies"]){
            self.textMovies.stringValue = files[0];
        }
        else if([pressedButton.identifier isEqualToString:@"TVSeries"]){
            self.textTvSeries.stringValue = files[0];
        }
        else {
            self.textDocumentaries.stringValue = files[0];
        }
        
        NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:files[0] includingPropertiesForKeys:@[NSFileSize, NSFileType] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
        
        NSLog(@"%@", [dirs description]);
        
        
        
        for (NSURL *file in dirs){
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath: [file path] error: NULL];
            NSLog(@"%@", [file lastPathComponent]);
            NSLog(@"%llu MB", (([attrs fileSize]/1000)/1000));
        }
    }
}
- (IBAction)buttonDownloads:(id)sender {
    [self openPanel:sender];
}

- (IBAction)buttonMovies:(id)sender {
    [self openPanel:sender];
}

- (IBAction)buttonTvSeries:(id)sender {
    [self openPanel:sender];
}

- (IBAction)buttonDocumentaries:(id)sender {
    [self openPanel:sender];
}



- (IBAction)saveButton:(id)sender {
    
    if(([self.textBlock.stringValue isEqualToString:@""]) || ([self.textRoomNo.stringValue isEqualToString:@""]) || ([self.textHostel.stringValue isEqualToString:@""])){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setInformativeText:@"Block, Room Number, and Hostel cannot be blank!"];
        [alert setMessageText:@"Nope"];
        [alert runModal];
        return;
    }
    
    NSArray *folders = @[self.textDownloads, self.textMovies, self.textTvSeries, self.textDocumentaries];
    
    unsigned int flag = 0;
    for(NSTextField *textField in folders){
        if(![textField.stringValue isEqualToString:@""]){
            flag = 1;
        }
    }
    
    if(!flag){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setInformativeText:@"Please specify atleast one folder!"];
        [alert setMessageText:@"Come On!"];
        [alert runModal];
        return;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *textFields = @[self.textDownloads, self.textMovies, self.textTvSeries, self.textDocumentaries, self.textBlock, self.textHostel, self.textRoomNo];
    
    for(NSTextField *textField in textFields){
        [defaults removeObjectForKey:textField.identifier];
        [defaults setObject:textField.stringValue forKey:textField.identifier];
    }
    NSLog(@"Saved!");
}
@end
