//
//  WindowController.h
//  VITCloud
//
//  Created by Siddharth Gupta on 12/9/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WindowController : NSWindow

@property (weak) IBOutlet NSTextField *folder1Path;
- (IBAction)folder1ButtonClicked:(id)sender;
@end
