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
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void)awakeFromNib{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.title = @"VITc";
    self.statusItem.highlightMode = YES;
    self.statusItem.menu = self.mainMenu;
    
    
}

@end
