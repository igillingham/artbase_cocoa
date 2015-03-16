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
NSString * const abApiNotifyMediumsJSONReady = @"abApiNotifyMediumsJSONReady";
NSString * const abApiNotifyMediumJSONReady = @"abApiNotifyMediumJSONReady";
NSString * const abApiNotifyDataReady = @"abApiNotifyDataReady";
NSString * const abApiNotifyArtworksReady = @"abApiNotifyArtworksReady";
NSString * const abApiNotifyArtworkReady = @"abApiNotifyArtworkReady";
NSString * const abApiNotifyMediumsReady = @"abApiNotifyMediumsReady";
NSString * const abApiNotifyMediumReady = @"abApiNotifyMediumReady";

NSString * const abApiNotifyPrintsReady = @"abApiNotifyPrintsReady";
NSString * const abApiNotifyPrintReady = @"abApiNotifyPrintReady";
NSString * const abApiNotifyPrintsJSONReady = @"abApiNotifyPrintsJSONReady";
NSString * const abApiNotifyPrintJSONReady = @"abApiNotifyPrintJSONReady";

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
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/aw/details/%ld",(long)iId]]];
    
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

- (void)requestAllMediums
{
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/mediums"]]];
    
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

- (void)updateMediumId:(NSInteger) iId withName:(NSString *)name
{
    NSLog(@"ABDatabase: updateMediumId: %ld withName: %@", iId, name);
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/medium/update/%ld",(long)iId]]];
    
    
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary* jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%li", (long)iId],@"id",
                                    name, @"medium",
                                    nil];
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    // Specify that it will be a PUT request
    request.HTTPMethod = @"PUT";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:jsonData];
    
    // If we want to consider posting JSON params at some stage
    //NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&encodeError];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // This is how we set header fields
    //[request setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

- (void)addMediumWithName:(NSString*)name
    {
    NSLog(@"ABDatabase: addMediumId: withName: %@", name);
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/medium"]]];
    
    
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary* jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:name, @"medium", nil];
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:jsonData];
    
    // If we want to consider posting JSON params at some stage
    //NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&encodeError];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // This is how we set header fields
    //[request setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }

- (void)requestMediumWithId:(NSInteger) iId
{
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/medium/%ld",(long)iId]]];
    
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

- (void)deleteMediumWithId:(NSInteger) iId
{
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/medium/%ld",(long)iId]]];
    
    // Specify that it will be a DELETE request
    request.HTTPMethod = @"DELETE";
    
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
    
    // This is how we set header fields
    [request setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)requestAllPrints
{
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/prints"]]];
    
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

- (void)requestPrintWithId:(NSInteger) iId
{
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://abapi.iangillingham.net/print/%ld",(long)iId]]];
    
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
    NSArray *datatypes = @[@"artwork", @"artworks", @"medium", @"mediums", @"gallery", @"galleries", @"print", @"prints", @"customer", @"customers"];
    
    NSMutableData *requestedData = [[notification object] getResponseData];
    NSString *requestedDataString = [[notification object] getResponseString];
    if (requestedData != nil)
        {NSLog(@"ArtbaseAPIClient received notification downloadFinished. requestedData = %@", requestedDataString);
        
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
            
            //NSLog(@"Results key = %@", [results key]);
            
            NSArray *allkeys = [results allKeys];
            NSLog(@"Results allkeys = %@", allkeys);
            
            NSUInteger datatype = [datatypes indexOfObject:allkeys[0]];
            NSLog(@"Key item = %lu", (unsigned long)datatype);
            
            NSDictionary *inner_result;
            
            switch (datatype)
                {
                    case 0: // Artwork
                        inner_result = [results objectForKey:@"artwork"];
                        if (inner_result != nil)
                            {
                            NSLog(@"ArtbaseAPIClient Found Artwork key");
                            UInt16 uiId;
                            uiId = [[inner_result objectForKey:@"id"] integerValue];
                            [[NSNotificationCenter defaultCenter]
                             postNotificationName:abApiNotifyArtworkJSONReady
                             object:inner_result];
                            }
                        break;
                    
                    case 1: // Artworks
                        inner_result = [results objectForKey:@"artworks"];
                        if (inner_result != nil)
                            {
                            NSLog(@"ArtbaseAPIClient Found Artworks key");
                            [[NSNotificationCenter defaultCenter]
                             postNotificationName:abApiNotifyArtworksJSONReady
                             object:inner_result];
                            }
                        break;
                    
                    case 2: // Medium
                        inner_result = [results objectForKey:@"medium"];
                        if (inner_result != nil)
                            {
                            NSLog(@"ArtbaseAPIClient Found Medium key");
                            [[NSNotificationCenter defaultCenter]
                             postNotificationName:abApiNotifyMediumJSONReady
                             object:inner_result];
                            }
                        break;
                    
                    case 3: // Mediums
                        inner_result = [results objectForKey:@"mediums"];
                        if (inner_result != nil)
                            {
                            NSLog(@"ArtbaseAPIClient Found Mediums key");
                            [[NSNotificationCenter defaultCenter]
                             postNotificationName:abApiNotifyMediumsJSONReady
                             object:inner_result];
                            }
                        break;
                    
                    case 4: // Gallery
                    break;
                    
                    case 5: // Galleries
                    break;
                    
                    case 6: // Print
                    inner_result = [results objectForKey:@"print"];
                    if (inner_result != nil)
                        {
                        NSLog(@"ArtbaseAPIClient Found Print key");
                        [[NSNotificationCenter defaultCenter]
                         postNotificationName:abApiNotifyPrintJSONReady
                         object:inner_result];
                        }
                    break;
                    
                    case 7: // Prints
                    inner_result = [results objectForKey:@"prints"];
                    if (inner_result != nil)
                        {
                        NSLog(@"ArtbaseAPIClient Found Prints key");
                        [[NSNotificationCenter defaultCenter]
                         postNotificationName:abApiNotifyPrintsJSONReady
                         object:inner_result];
                        }
                    break;
                    
                    case 8: // Customer
                    break;
                    
                    case 9: // Customers
                    break;
                    
                default:
                    break;
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
    else
        {
        NSLog(@"ArtbaseAPIClient received notification downloadFinished - but no data returned from server");
        }
}


@end
