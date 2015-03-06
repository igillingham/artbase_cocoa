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

- (IBAction)btnTestGetAction:(id)sender
    {
    [self.apiClient requestArtworkWithId:[self.currentArtworkId integerValue]];
    }

- (IBAction)stepSelector:(id)sender
    {
    NSLog(@"stepSelector! %d", self.stepArtworkId.intValue);
    [self.currentArtworkId setIntValue:self.stepArtworkId.intValue];

    }

- (IBAction)btnAddAction:(id)sender
    {
    NSLog(@"Add button pressed");
    }

- (IBAction)btnTestWebReq:(id)sender
    {
    }

- (IBAction)btnTestPostAction:(id)sender
    {
    NSLog(@"POST button pressed");
    NSLog(@"buttonPressed: Setting up request");
    //soStatus.text = @"Pressed!";
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://abapi.iangillingham.net"]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    //initialize a post data
    NSString *postParams = @"/aw/name/2";
    NSString *postData = [[NSString alloc] initWithString:postParams];
    //set request content type we MUST set this value.
    
    // This is how we set header fields
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //set post data of request
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    // If we want to consider posting JSON params at some stage
    //NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&encodeError];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // Convert your data and set your request's HTTPBody property
    if (self.connection != nil)
        {
        [self.connection cancel];
        }
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self.apiClient];
    
    self.connection = conn;
    
    //start the connection
    [conn start];
    
    if (conn!=nil)
        {
        NSString* myString;
        myString = self.apiClient.getResponseString;
        //[self.lblStatus] text
        NSLog(@"buttonPressed: Request completed");
        NSLog(@"%@", myString);
        
        NSMutableData *data = self.apiClient.getResponseData;
        NSError *err = self.apiClient.getError;
        
        if (data.length > 0 && err == nil)
            {
            NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:NULL];
            NSLog(@"JSON dictionary: %@", greeting);
            }
        }
    }




@end
