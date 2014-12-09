//
//  AppDelegate.h
//  VITCloud
//
//  Created by Siddharth Gupta on 12/8/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property NSStatusItem *statusItem;
@property (strong) IBOutlet NSMenu *mainMenu;
@property (weak) IBOutlet NSWindow *window;

@end

