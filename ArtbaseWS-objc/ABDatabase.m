//
//  ABDatabase.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 01/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ABDatabase.h"

NSString * const abApiNotifyArtworksJSONReady = @"abApiNotifyArtworksJSONReady";
NSString * const abApiNotifyArtworkJSONReady = @"abApiNotifyArtworkJSONReady";
NSString * const abApiNotifyDataReady = @"abApiNotifyDataReady";
NSString * const abApiNotifyArtworksReady = @"abApiNotifyArtworksReady";
NSString * const abApiNotifyArtworkReady = @"abApiNotifyArtworkReady";

@implementation ArtbaseAPIClient

- (id)init
    {
    self = [super init];
    // Receive notification messages
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadFinished:)
                                                 name:abApiNotifyDataReady
                                               object:nil];

    return self;
    }

- (void)getArtworkName:(int)awid
    {
    
    }

- (NSString *)getResponseString
    {
    NSString* myString;
    myString = [[NSString alloc] initWithData:_receivedData encoding:NSASCIIStringEncoding];
    return myString;
    }

- (NSMutableData *)getResponseData
    {
    return self.receivedData;
    }

- (NSError *)getError
    {
    return _err;
    }

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
    {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSRange range = NSMakeRange(200, 99);
    if (NSLocationInRange(httpResponse.statusCode, range))
        {
        self.receivedData = [[NSMutableData alloc] init];
        }
    
    NSLog(@"Delegate: didReceiveResponse - HTTP Status code: %ld", (long)httpResponse.statusCode);
    }

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
    {
    // Append the new data to the instance variable you declared
    [self.receivedData appendData:data];
    NSLog(@"Delegate: didReceiveData");
    NSLog(@"%@", self.getResponseString);
    }

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
    {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
    }

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
    {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSLog(@"Delegate: connectionDidFinishLoading");
    // inform caller that download is complete, provide data ...

    //initialize convert the received data to string with UTF8 encoding
    NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData
                                              encoding:NSUTF8StringEncoding];
    NSLog(@"%@" , htmlSTR);
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:abApiNotifyDataReady
     object:self];
    }

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
    {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Delegate: Connection Failed with error: %@", error);
    }

- (void)requestAllArtworks
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
    
     // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    }

- (void)requestArtworkWithId:(NSInteger) iId
    {
    NSLog(@"Test button pressed");
    NSLog(@"buttonPressed: Setting up request");
    //soStatus.text = @"Pressed!";
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/aw/name/%ld",(long)iId]]];
    
    // Specify that it will be a GET request
    request.HTTPMethod = @"GET";
    
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // This is how we set header fields
    [request setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
 
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    }

- (void)downloadFinished:(NSNotification *)notification
{
    NSMutableData *requestedData = [[notification object] getResponseData];
    NSString *requestedDataString = [[notification object] getResponseString];
    NSLog(@"ArtbaseAPIClient received notification downloadFinished. requestedData = %@", requestedDataString);
    
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
        //NSLog(@"JSON decoded: %@", results );
        //NSLog(@"All keys: %@", [results allKeys]);
        
        NSDictionary *inner_result = [results objectForKey:@"artwork"];
        if (inner_result != nil)
            {
            NSLog(@"ArtbaseAPIClient Found Artwork key");
            UInt16 uiId;
            uiId = [[inner_result objectForKey:@"id"] integerValue];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:abApiNotifyArtworkJSONReady
             object:inner_result];

            //NSString *strName = (NSString *)[inner_result objectForKey:@"name"];
            //NSLog(@"uiId: %d   Name: %@", uiId, strName);
            
            }
        else
            {
            //NSArray *notifications = [[theFeedString JSONValue] objectForKey:@"notification"];
            // or whatever JSON helper you are using
            inner_result = [results objectForKey:@"artworks"];
            if (inner_result != nil)
                {
                NSLog(@"ArtbaseAPIClient Found Artworks key");
                [[NSNotificationCenter defaultCenter]
                postNotificationName:abApiNotifyArtworksJSONReady
                object:inner_result];

                //[self.artworkTableView reloadData];
                
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


@end
