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
@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) IBOutlet NSTableView *detailTableView;
@property (strong,retain) NSMutableArray *artworksArray;

/*
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;

- (void)tableView:(NSTableView *)aTableView
   setObjectValue:(id)anObject
   forTableColumn:(NSTableColumn *)aTableColumn
              row:(NSInteger)rowIndex;
*/
- (void)appendArtworkWithId:(UInt16)uid withName:(NSString *)name;

- (void)clear;

@end
