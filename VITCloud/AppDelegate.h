//
//  AppDelegate.h
//  VITCloud
//
//  Created by Siddharth Gupta on 12/8/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BackgroundOperations.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property NSStatusItem *statusItem;
@property (strong) IBOutlet NSMenu *mainMenu;
@property (weak) IBOutlet NSWindow *window;

-(void)setStatus:(NSString *)text;
-(void)setStatusIconProgress:(BOOL)boolean;

@property (weak) IBOutlet NSMenuItem *statusText;

- (IBAction)openPreferences:(id)sender;
- (IBAction)openAbout:(id)sender;
- (IBAction)quitApp:(id)sender;
@property (weak) IBOutlet NSMenuItem *scanNowButton;
- (IBAction)scanNowPressed:(id)sender;

-(void)initEverything;

@end

