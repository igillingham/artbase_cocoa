//
//  ViewController.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 23/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ArtworkEntity.h"
#import "ABArtworks.h"


@interface ViewController : NSViewController

//IBOutlet NSTableView *artworkTableView;

@property (weak) IBOutlet NSTableColumn *artworkId;
@property (nonatomic,retain) IBOutlet NSTableView *artworkTableView;


@property (weak) IBOutlet NSTextFieldCell *lblStatus;
@property (retain, nonatomic) NSURLConnection *connection;

@property (retain, nonatomic) ArtworkEntity *awEntity;
@property (retain) IBOutlet ABArtworks *abArtworksDataSource;

- (IBAction)btnAddAction:(id)sender;
- (IBAction)btnTestPostAction:(id)sender;
- (IBAction)btnTestGetAction:(id)sender;
- (IBAction)stepSelector:(id)sender;
- (IBAction)btnGetAllArtworks:(id)sender;
@property (weak) IBOutlet NSStepper *stepArtworkId;
@property (weak) IBOutlet NSTextField *currentArtworkId;

- (IBAction)btnTestWebReq:(id)sender;
- (void)downloadFinished:(NSNotification *)notification;
@property (weak) IBOutlet NSTableColumn *artworksIdTableColumn;
@property (weak) IBOutlet NSTableColumn *artworksNameTableColumn;


@end
