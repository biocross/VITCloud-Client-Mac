//
//  AppDelegate.m
//  VITCloud
//
//  Created by Siddharth Gupta on 12/8/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "AppDelegate.h"
#import "BackgroundOperations.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.title = @"";
    self.statusItem.image = [NSImage imageNamed:@"Cloud_Cloud"];
    
    [self initEverything];
}

-(void)initEverything{
    
    
    self.scanNowButton.enabled = NO;
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"basicSetupComplete"] isEqualToString:@"YES"]){
        [self.window close];
        [self setStatus:@"Idle"];
        self.scanNowButton.enabled = YES;
        [NSTimer scheduledTimerWithTimeInterval:7200.0 target:self selector:@selector(beginScanning) userInfo:nil repeats:YES];
        
    }
    else{
        NSLog(@"Basic Parameters are needed. Opening Prefs Window");
        [self setStatus:@"Basic Setup Required"];
    }
    
    
    self.statusItem.toolTip = [NSString stringWithFormat:@"VITCloud | %@", self.statusText.title];
    self.statusItem.highlightMode = YES;
    self.statusItem.menu = self.mainMenu;
}

-(void)beginScanning{
    [[BackgroundOperations singleton] beginScanning];
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
- (IBAction)scanNowPressed:(id)sender {
    [self beginScanning];
}
@end
