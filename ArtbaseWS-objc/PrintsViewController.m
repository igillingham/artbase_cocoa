//
//  PrintsViewController.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 13/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "PrintsViewController.h"


@implementation PrintsViewController

@synthesize abPrintsDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.apiClient = [[ArtbaseAPIClient alloc] init];
    
    self.abPrintsDataSource = [[ABPrints alloc] init];
    [self.abPrintsDataSource setParent:self];
    [self.printTableView setDelegate:self.abPrintsDataSource];
    [self.printTableView setDataSource:self.abPrintsDataSource];
    self.iRowSelected = -1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePrints:)
                                                 name:abApiNotifyPrintsReady
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePrintItem:)
                                                 name:abApiNotifyPrintReady
                                               object:nil];
}

- (IBAction)btnGetPrints:(id)sender
{
    NSLog(@"PrintsViewController - btnGetPrints button presssed");
    [self.apiClient requestAllPrints];
}

- (IBAction)rowAnythingChangeSelected:(id)sender
{
    NSInteger iRow = [self.printTableView selectedRow];
    self.iRowSelected = (int)iRow;
    NSLog(@"PrintViewController: rowChangeSelected row = %ld", iRow);
    if (iRow >= 0)
        {
        PrintEntity *pPrint = [self.abPrintsDataSource getPrintAtIndex:iRow];
        NSInteger serial = [pPrint serial];
        NSInteger index = [pPrint index];
        [self.apiClient requestPrintWithId:index];
        //[self.detailsName setStringValue:name];
        //[self.textEditUpdate setStringValue:name];
        }
}

- (void)reloadData
{
    [self.printTableView reloadData];
}


- (void)updatePrints:(NSNotification *)notification
{
    
    [self reloadData];
}

- (void)updatePrintItem:(NSNotification *)notification
{
    
}

@end
