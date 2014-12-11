//
//  AppDelegate.m
//  VITCloud
//
//  Created by Siddharth Gupta on 12/8/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.title = @"VITc";
    self.statusItem.highlightMode = YES;
    self.statusItem.menu = self.mainMenu;
        
    [self.window close];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


-(void)setStatus:(NSString *)text{
    [self.statusText setTitle:text];
}

-(void)setStatusIconProgress:(BOOL)boolean{
    if(boolean){
        //set Animating Icon
    }
    else{
        //set normal icon
    }
}




- (IBAction)openPreferences:(id)sender {
    NSWindowController *controllerWindow = [[NSWindowController alloc] initWithWindow:self.window];
    [controllerWindow showWindow:self];
}

- (IBAction)openAbout:(id)sender {
}

- (IBAction)quitApp:(id)sender {
}
@end
