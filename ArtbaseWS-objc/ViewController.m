//
//  ViewController.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 23/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//
//#import <AFNetworking/AFNetworking.h>
//#import <AFNetworking/AFJSONRequestOperation.h>
//#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ViewController.h"
#import "TableController.h"
#import "ABDatabase.h"

@implementation ViewController

@synthesize artworkId;
@synthesize abArtworksDataSource;


- (void)viewDidLoad
    {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self.lblStatus setStringValue:@"init"];
    [self.currentArtworkId setStringValue:@"0"];

    self.apiClient = [[ArtbaseAPIClient alloc] init];
    
    self.abArtworksDataSource = [[ABArtworks alloc] init];
    [self.abArtworksDataSource setParent:self];
    //self.artworkTableView = [[NSTableView alloc] init];
    [self.artworkTableView setDelegate:self.abArtworksDataSource];
    [self.artworkTableView setDataSource:self.abArtworksDataSource];
    
    // Instantiate a single ArtworkEntity
    // Set the Artwork ID stepper control parameters
    [self.stepArtworkId setMinValue:0];
    [self.stepArtworkId setMaxValue:256];
    [self.stepArtworkId setIncrement:1];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateArtworks:)
                                                 name:abApiNotifyArtworksReady
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateArtworkItem:)
                                                 name:abApiNotifyArtworkReady
                                               object:nil];
    }

- (IBAction)rowAnythingChangeSelected:(id)sender
    {
    NSInteger iRow = [self.artworkTableView selectedRow];
    NSLog(@"ViewController: rowChangeSelected row = %ld", iRow);
    ArtworkEntity *pArtwork = [self.abArtworksDataSource getArtworkAtIndex:iRow];
    NSString *name = [pArtwork name];
    NSInteger index = [pArtwork index];
    [self.apiClient requestArtworkWithId:index];
    [self.detailsName setStringValue:name];
    }

- (void)updateArtworks:(NSNotification *)notification
    {
    [self reloadData];
    }

- (void)updateArtworkItem:(NSNotification *)notification
    {
    ArtworkEntity *aw = (ArtworkEntity *)[notification object];
    [self.detailsMedium setIntegerValue:[aw medium]];
    [self.detailsLocation setIntegerValue:[aw presentLocation]];
    if ([aw date_of_sale] != nil)
        [self.detailsDateOfSale setStringValue:[aw date_of_sale]];
    if ([aw information] != nil)
        [self.detailsInformation setStringValue:[aw information]];
    [self.detailsLocation setIntegerValue:[aw presentLocation]];
    [self.printsLimitedEdition setIntegerValue:[aw limited_edition]];
    [self.printsNumberSold setIntegerValue:[aw prints_sold]];
    [self reloadData];
    }

- (void)reloadData
    {
    [self.artworkTableView reloadData];
    }

- (void)setRepresentedObject:(id)representedObject
    {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
    }

- (IBAction)btnGetAllArtworks:(id)sender
    {
    [self.apiClient requestAllArtworks];
    }


- (IBAction)btnAddAction:(id)sender
    {
    NSLog(@"Add button pressed");
    }



@end
