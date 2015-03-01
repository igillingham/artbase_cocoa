//
//  ABArtworks.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 15/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

#import "ArtworkEntity.h"

@interface ABArtworks : NSObject<NSTableViewDataSource, NSTableViewDelegate>
    {
    IBOutlet NSView *tableViewPlaceholderView;
    }
@property (assign)NSViewController *parent;
@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) IBOutlet NSTableView *detailTableView;
@property (strong,retain) NSMutableArray *artworksArray;
@property (strong,retain) ArtworkEntity *artworkItem;
- (void)appendArtworkWithId:(UInt16)uid withName:(NSString *)name;
- (ArtworkEntity *)getArtworkAtIndex:(UInt16)iIndex;

- (void)clear;
- (void)dataReady:(NSNotification *)notification;
- (void)artworkJSONReady:(NSNotification *)notification;
@end
