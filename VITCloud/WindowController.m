//
//  WindowController.m
//  VITCloud
//
//  Created by Siddharth Gupta on 12/9/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "WindowController.h"
#import "BackgroundOperations.h"

@implementation WindowController

-(void)awakeFromNib{
    NSLog(@"Awake");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *textFields = @[self.textDownloads, self.textMovies, self.textTvSeries, self.textDocumentaries, self.textBlock, self.textHostel, self.textRoomNo];
    
    for(NSTextField *textField in textFields){
        if([[defaults objectForKey:textField.identifier] isKindOfClass:[NSURL class]]){
            textField.stringValue = [[defaults URLForKey:textField.identifier] path];
        }
        else if([[defaults objectForKey:textField.identifier] isKindOfClass:[NSString class]]){
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
        
        
        if([pressedButton.identifier isEqualToString:@"textDownloads"]){
            self.textDownloads.stringValue = files[0];
        }
        else if([pressedButton.identifier isEqualToString:@"textMovies"]){
            self.textMovies.stringValue = files[0];
        }
        else if([pressedButton.identifier isEqualToString:@"textTVSeries"]){
            self.textTvSeries.stringValue = files[0];
        }
        else {
            self.textDocumentaries.stringValue = files[0];
        }
        
        //Save URL to NSUserDefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:pressedButton.identifier];
        [defaults setURL:files[0] forKey:pressedButton.identifier];
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
    
    //Saving User Data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *textFields = @[self.textBlock, self.textHostel, self.textRoomNo];
    
    for(NSTextField *textField in textFields){
        [defaults removeObjectForKey:textField.identifier];
        [defaults setObject:textField.stringValue forKey:textField.identifier];
    }
    [defaults setObject:@"YES" forKey:@"basicSetupComplete"];
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [appDelegate initEverything];
    NSLog(@"Saved!");
}

- (IBAction)scanNowButton:(id)sender {
    [[BackgroundOperations singleton] beginScanning];
}

- (IBAction)removeDownloads:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"textDownloads"];
    self.textDownloads.stringValue = @"";
}

- (IBAction)removeMovies:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"textMovies"];
    self.textMovies.stringValue = @"";
}

- (IBAction)removeTVSeries:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"textTVSeries"];
    self.textTvSeries.stringValue = @"";
}

- (IBAction)removeDocumentaries:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"textDocumentaries"];
    self.textDocumentaries.stringValue = @"";
}
@end
