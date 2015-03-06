//
//  MediumViewController.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 03/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MediumEntity.h"
#import "ABMediums.h"
#import "ABDatabase.h"

@interface MediumViewController : NSViewController
@property (nonatomic,retain) IBOutlet NSTableView *mediumTableView;
@property (retain) IBOutlet ABMediums *abMediumsDataSource;
@property (retain) ArtbaseAPIClient *apiClient;
//- (IBAction)btnGetAllMediums:(id)sender;
- (IBAction)rowAnythingChangeSelected:(id)sender;
- (void)updateMediums:(NSNotification *)notification;
- (void)updateMediumItem:(NSNotification *)notification;
- (IBAction)btnUpdatePressed:(id)sender;
- (IBAction)btnDeletePressed:(id)sender;
- (IBAction)btnAddPressed:(id)sender;
- (void)reloadData;
@property (weak) IBOutlet NSTableColumn *mediumsIdTableColumn;
@property (weak) IBOutlet NSTableColumn *mediumsNameTableColumn;
@property (weak) IBOutlet NSFormCell *detailsName;
@property (weak) IBOutlet NSButton *btnGetMediums;
@property (weak) IBOutlet NSTextField *textEditUpdate;
@property (weak) IBOutlet NSTextField *textEditAdd;
- (IBAction)getMediumsButton:(id)sender;
@property int iRowSelected;
@end
