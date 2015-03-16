//
//  ABMediums.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 03/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "MediumEntity.h"

@interface ABMediums : NSObject<NSTableViewDataSource, NSTableViewDelegate>

@property (assign)NSViewController *parent;
@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) IBOutlet NSTableView *detailTableView;
@property (strong,retain) NSMutableArray *mediumsArray;
@property (strong,retain) MediumEntity *mediumItem;
- (void)appendMediumWithId:(UInt16)uid withName:(NSString *)name;
- (void)updateMediumAtIndex:(UInt16)uid withName:(NSString *)name;
- (void)addMedium:(NSString*)name;
- (MediumEntity *)getMediumAtIndex:(UInt16)iIndex;
- (void)deleteMediumAtIndex:(UInt16)iIndex;
- (void)clear;
- (void)mediumJSONReady:(NSNotification *)notification;
- (void)mediumsJSONReady:(NSNotification *)notification;

@end
