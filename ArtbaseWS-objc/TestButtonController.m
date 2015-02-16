//
//  TestButtonController.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 30/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "TestButtonController.h"
#import "ABDatabase.h"

@implementation TestButtonController
- (IBAction)buttonPressed
    {
    NSLog(@"buttonPressed: Setting up request");
    //soStatus.text = @"Pressed!";
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://abapi.iangillingham.net/aw/name/2"]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // This is how we set header fields
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData = @"/aw/name/2";
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    NSLog(@"buttonPressed: Request completedd");

    }

@end
