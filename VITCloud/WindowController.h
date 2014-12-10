//
//  WindowController.h
//  VITCloud
//
//  Created by Siddharth Gupta on 12/9/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WindowController : NSWindow


@property (weak) IBOutlet NSTextField *textDownloads;
@property (weak) IBOutlet NSTextField *textMovies;
@property (weak) IBOutlet NSTextField *textTvSeries;
@property (weak) IBOutlet NSTextField *textDocumentaries;

- (IBAction)buttonDownloads:(id)sender;
- (IBAction)buttonMovies:(id)sender;
- (IBAction)buttonTvSeries:(id)sender;
- (IBAction)buttonDocumentaries:(id)sender;

@property (weak) IBOutlet NSTextField *textBlock;
@property (weak) IBOutlet NSTextField *textRoomNo;
@property (weak) IBOutlet NSComboBox *textHostel;
- (IBAction)saveButton:(id)sender;

- (IBAction)removeDownloads:(id)sender;
- (IBAction)removeMovies:(id)sender;
- (IBAction)removeTVSeries:(id)sender;
- (IBAction)removeDocumentaries:(id)sender;
@end
