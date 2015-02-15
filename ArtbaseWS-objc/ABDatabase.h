//
//  ABDatabase.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 01/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

extern NSString * const abApiBaseURLString;
extern NSString * const abApiNotifyDataReady;

//  Integrate NSTableViewDataSource protocol to allow populating TableView
//  See: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/TableView/PopulatingCellTables/PopulatingCellTables.html
//
@interface ArtbaseAPIClient: NSObject<NSURLConnectionDelegate>

@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain,nonatomic) NSError *err;
- (NSMutableData *)getResponseData;
- (NSString *)getResponseString;
- (NSError *)getError;

@end
