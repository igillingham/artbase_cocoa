//
//  MediumViewController.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 03/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "MediumViewController.h"


@implementation MediumViewController

@synthesize abMediumsDataSource;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.apiClient = [[ArtbaseAPIClient alloc] init];
    
    self.abMediumsDataSource = [[ABMediums alloc] init];
    [self.abMediumsDataSource setParent:self];
    //self.artworkTableView = [[NSTableView alloc] init];
    [self.mediumTableView setDelegate:self.abMediumsDataSource];
    [self.mediumTableView setDataSource:self.abMediumsDataSource];
    self.iRowSelected = -1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMediums:)
                                                 name:abApiNotifyMediumsReady
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMediumItem:)
                                                 name:abApiNotifyMediumReady
                                               object:nil];
}

- (IBAction)getMediumsButton:(id)sender
    {
    NSLog(@"getMediumsButton clicked");
    [self.apiClient requestAllMediums];
    }


- (IBAction)rowAnythingChangeSelected:(id)sender
    {
    NSInteger iRow = [self.mediumTableView selectedRow];
    self.iRowSelected = (int)iRow;
    NSLog(@"ViewController: rowChangeSelected row = %ld", iRow);
    if (iRow >= 0)
        {
        MediumEntity *pMedium = [self.abMediumsDataSource getMediumAtIndex:iRow];
        NSString *name = [pMedium name];
        NSInteger index = [pMedium index];
        [self.apiClient requestMediumWithId:index];
        [self.detailsName setStringValue:name];
        [self.textEditUpdate setStringValue:name];
        }
    }

- (void)updateMediums:(NSNotification *)notification
{

    [self reloadData];
}

- (void)updateMediumItem:(NSNotification *)notification
{
   
}

- (IBAction)btnUpdatePressed:(id)sender
    {
    NSLog(@"Update row pressed. Row = %d", [self iRowSelected]);
    if ([self iRowSelected] >= 0)
        {
        MediumEntity *entity = [self.abMediumsDataSource getMediumAtIndex:self.iRowSelected];
        NSString *name = [self.textEditUpdate stringValue];
        NSLog(@"Update string: %@", name);
        [self.abMediumsDataSource updateMediumAtIndex:[self iRowSelected] withName:name];
        [self.apiClient updateMediumId:[entity index] withName:name];
        [self reloadData];
        }

    }

- (IBAction)btnDeletePressed:(id)sender
{
    NSLog(@"Delete row pressed");
    if (self.iRowSelected > -1)
        {
        MediumEntity *entity = [self.abMediumsDataSource getMediumAtIndex:self.iRowSelected];
        [self.abMediumsDataSource deleteMediumAtIndex:self.iRowSelected];
        [self reloadData];
        [self.apiClient deleteMediumWithId:[entity index]];
        }
}

- (IBAction)btnAddPressed:(id)sender
    {
    NSString *name = [self.textEditAdd stringValue];
    NSLog(@"Add string: %@", name);
    //[self.abMediumsDataSource :[self iRowSelected] withName:name];
    [self.apiClient addMediumWithName:name];
    [self reloadData];
    }

- (void)reloadData
    {
    [self.mediumTableView reloadData];
    }



@end
