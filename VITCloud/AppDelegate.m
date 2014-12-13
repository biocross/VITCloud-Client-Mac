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
    self.statusItem.title = @"";
    self.statusItem.image = [NSImage imageNamed:@"Cloud_Cloud"];
    [self setStatus:@"Idle"];
    self.statusItem.toolTip = [NSString stringWithFormat:@"VITCloud | %@", self.statusText.title];
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
        self.statusItem.image = [NSImage imageNamed:@"Cloud_Sync"];
    }
    else{
        //set normal icon
        self.statusItem.image = [NSImage imageNamed:@"Cloud_Cloud"];
    }
}

- (IBAction)openPreferences:(id)sender {
    NSWindowController *controllerWindow = [[NSWindowController alloc] initWithWindow:self.window];
    [controllerWindow showWindow:self];
    
    [self.window orderFrontRegardless];
}

- (IBAction)openAbout:(id)sender {
}

- (IBAction)quitApp:(id)sender {
}
@end
