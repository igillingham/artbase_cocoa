//
//  ABDatabase.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 01/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ABDatabase.h"

NSString * const abApiNotifyDataReady = @"abApiNotifyDataReady";

@implementation ArtbaseAPIClient
    
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
@end
