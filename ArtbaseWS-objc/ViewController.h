//
//  ViewController.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 23/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ArtworkEntity.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTableColumn *artworkId;

@property (weak) IBOutlet NSTextFieldCell *lblStatus;
@property (retain, nonatomic) NSURLConnection *connection;

@property (retain, nonatomic) ArtworkEntity *awEntity;

- (IBAction)btnTestPostAction:(id)sender;
- (IBAction)btnTestGetAction:(id)sender;
- (IBAction)stepSelector:(id)sender;
@property (weak) IBOutlet NSStepper *stepArtworkId;
@property (weak) IBOutlet NSTextField *currentArtworkId;

- (IBAction)btnTestWebReq:(id)sender;
- (void)downloadFinished:(NSNotification *)notification;

@end
