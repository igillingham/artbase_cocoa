//
//  PrintsViewController.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 13/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PrintEntity.h"
#import "ABDatabase.h"
#import "ABPrints.h"

@interface PrintsViewController : NSViewController
- (IBAction)btnGetPrints:(id)sender;
@property (retain) IBOutlet ABPrints *abPrintsDataSource;
@property (retain) ArtbaseAPIClient *apiClient;
@property (nonatomic,retain) IBOutlet NSTableView *printTableView;
- (void)updatePrints:(NSNotification *)notification;
- (void)updatePrintItem:(NSNotification *)notification;
- (void)reloadData;

@property (weak) IBOutlet NSFormCell *detailsName;
@property int iRowSelected;


@property (weak) IBOutlet NSTableColumn *printsColId;
@property (weak) IBOutlet NSTableColumn *printsColSerial;
@property (weak) IBOutlet NSTableColumn *printsColDateSold;
@property (weak) IBOutlet NSTableColumn *printsColArtworkId;
@end
