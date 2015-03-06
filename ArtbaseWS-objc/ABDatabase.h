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
extern NSString * const abApiNotifyArtworksReady;
extern NSString * const abApiNotifyArtworkReady;
extern NSString * const abApiNotifyArtworksJSONReady;
extern NSString * const abApiNotifyArtworkJSONReady;
extern NSString * const abApiNotifyMediumsReady;
extern NSString * const abApiNotifyMediumReady;
extern NSString * const abApiNotifyMediumsJSONReady;
extern NSString * const abApiNotifyMediumJSONReady;

//  Integrate NSTableViewDataSource protocol to allow populating TableView
//  See: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/TableView/PopulatingCellTables/PopulatingCellTables.html
//
@interface ArtbaseAPIClient: NSObject<NSURLConnectionDelegate>

@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain,nonatomic) NSError *err;
- (id)init;
- (NSMutableData *)getResponseData;
- (NSString *)getResponseString;
- (NSError *)getError;

- (void)requestAllArtworks;
- (void)requestArtworkWithId:(NSInteger) iId;
- (void)requestAllMediums;
- (void)requestMediumWithId:(NSInteger) iId;
- (void)downloadFinished:(NSNotification *)notification;
@end
