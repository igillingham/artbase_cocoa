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


- (void)viewDidLoad
    {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self.lblStatus setStringValue:@"init"];
    [self.currentArtworkId setStringValue:@"0"];
    
    self.abArtworksDataSource = [[ABArtworks alloc] init];
    self.artworkTableView.delegate = self.abArtworksDataSource;
    
    // Instantiate a single ArtworkEntity
    self.awEntity = [[ArtworkEntity alloc] init];
    // Set the Artwork ID stepper control parameters
    [self.stepArtworkId setMinValue:0];
    [self.stepArtworkId setMaxValue:256];
    [self.stepArtworkId setIncrement:1];

    // Receive notification messages
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadFinished:)
                                                 name:abApiNotifyDataReady
                                               object:nil];
    }

- (void)downloadFinished:(NSNotification *)notification
    {
    NSMutableData *requestedData = [[notification object] getResponseData];
    NSString *requestedDataString = [[notification object] getResponseString];
    NSLog(@"ViewController received notification downloadFinished. requestedData = %@", requestedDataString);
    [_lblStatus setStringValue:requestedDataString];
    
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:requestedData
                 options:0
                 error:&error];
    
    if(error) { /* JSON was malformed, act appropriately here */ }
    
    // the originating poster wants to deal with dictionaries;
    // assuming you do too then something like this is the first
    // validation step:
    if([object isKindOfClass:[NSDictionary class]])
        {
        NSMutableDictionary *results = object;
        NSLog(@"JSON decoded: %@", results );
        NSLog(@"All keys: %@", [results allKeys]);
        
        NSDictionary *inner_result = [results objectForKey:@"artwork"];
        if (inner_result != nil)
            {
            NSLog(@"Found Artwork key");
            UInt16 uiId;
            uiId = [[inner_result objectForKey:@"id"] integerValue];
            NSString *strName = (NSString *)[inner_result objectForKey:@"name"];
            NSLog(@"uiId: %d   Name: %@", uiId, strName);

            [self.lblStatus setStringValue:strName];
            //self.awEntity.id = uiId;
            //self.awEntity.name = strName;
            TableController *tc = [TableController alloc];
            tc.tableArtworkName.stringValue = strName;
           }
        else
            {
            //NSArray *notifications = [[theFeedString JSONValue] objectForKey:@"notification"];
            // or whatever JSON helper you are using
            inner_result = [results objectForKey:@"artworks"];
            if (inner_result != nil)
                {
                NSLog(@"Found Artworks key");

                for (NSDictionary *dict in inner_result)
                    {
                    NSInteger uid = [[dict objectForKey:@"id"] intValue];
                    NSString *name = [dict objectForKey:@"name"];
                    NSLog(@"Artwork: %ld   Name: %@", (long)uid, name);
                    [self.abArtworksDataSource appendArtworkWithId:uid withName:name];
                    
                    // do something with uid and count
                    }

                
                /*
                UInt16 uiId;
                uiId = [[inner_result objectForKey:@"id"] integerValue];
                NSString *strName = (NSString *)[inner_result objectForKey:@"name"];
                NSLog(@"uiId: %d   Name: %@", uiId, strName);
                
                [self.lblStatus setStringValue:strName];
                //self.awEntity.id = uiId;
                //self.awEntity.name = strName;
                TableController *tc = [TableController alloc];
                tc.tableArtworkName.stringValue = strName;
                */
                }

            }
        }
    else
        {
        /* there's no guarantee that the outermost object in a JSON
         packet will be a dictionary; if we get here then it wasn't,
         so 'object' shouldn't be treated as an NSDictionary; probably
         you need to report a suitable error condition */
        }
    }

- (void)setRepresentedObject:(id)representedObject
    {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
    }

- (IBAction)btnGetAllArtworks:(id)sender
    {
    NSLog(@"Get All Artworks button pressed");
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/aw/names"]]];
    
    // Specify that it will be a GET request
    request.HTTPMethod = @"GET";
    
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // If we want to consider posting JSON params at some stage
    //NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&encodeError];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // This is how we set header fields
    [request setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if (self.connection != nil)
        {
        [self.connection cancel];
        }
    
    ArtbaseAPIClient *apicli = [ArtbaseAPIClient alloc];
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:apicli];
    
    }

- (IBAction)btnTestGetAction:(id)sender
    {
    NSLog(@"Test button pressed");
    NSLog(@"buttonPressed: Setting up request");
    //soStatus.text = @"Pressed!";
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/aw/name/%d",self.stepArtworkId.intValue]]];
    
    // Specify that it will be a GET request
    request.HTTPMethod = @"GET";
    
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // If we want to consider posting JSON params at some stage
    //NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&encodeError];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // This is how we set header fields
    [request setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if (self.connection != nil)
        {
        [self.connection cancel];
        }
    
    ArtbaseAPIClient *apicli = [ArtbaseAPIClient alloc];
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:apicli];
    
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
    //NSString *stringData = @"";
    //NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    //request.HTTPBody = requestBodyData;
    
    if (self.connection != nil)
        {
        [self.connection cancel];
        }
    
    ArtbaseAPIClient *apicli = [ArtbaseAPIClient alloc];
    // Create url connection and fire request
    // NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:apicli];
    
    self.connection = conn;
    
    //start the connection
    [conn start];
    
    if (conn!=nil)
        {
        NSString* myString;
        myString = apicli.getResponseString;
        //[self.lblStatus] text
        NSLog(@"buttonPressed: Request completed");
        NSLog(@"%@", myString);
        
        NSMutableData *data = apicli.getResponseData;
        NSError *err = apicli.getError;
        
        if (data.length > 0 && err == nil)
            {
            NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:NULL];
            NSLog(@"JSON dictionary: %@", greeting);
            //self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
            //self.greetingContent.text = [greeting objectForKey:@"content"];
            }
        }
    }



@end
