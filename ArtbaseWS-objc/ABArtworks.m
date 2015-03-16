//
//  ABArtworks.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 15/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ABArtworks.h"
#import "ABDatabase.h"


@implementation ABArtworks

-(id)init
    {
    self = [super init];
    NSLog(@"ABArtworks init");
    // Indicate no parent until it has been assigned later by a parent
    self.parent = nil;
    // Allocate artworks array and initialise
    [self setArtworksArray:[[NSMutableArray alloc] init]];
    [self setArtworkItem:[[ArtworkEntity alloc] init]];
    [self clear];
    // Receive notification messages
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataReady:)
                                                 name:abApiNotifyArtworksJSONReady
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(artworkJSONReady:)
                                                 name:abApiNotifyArtworkJSONReady
                                               object:nil];

    return self;
    }

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
    {
    NSInteger uiCount = (NSInteger)[_artworksArray count];
    NSLog(@"ABArtworks numberOfRowsInTableView %lu", (unsigned long)uiCount);
    return uiCount;
    }

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
    {
    NSTableCellView *result;
    NSLog(@"ABArtworks viewForTableColumn");
    if ([self.artworksArray count] > row)
        {
        NSTableCellView *tableCellView = [tableView makeViewWithIdentifier:@"artworkTableView" owner:self];
        if ([[tableColumn identifier] isEqualToString:@"artworkId"])
            {
            NSLog(@"tableColumn = artworkIdCol");
            [[tableCellView textField] setObjectValue:@"Artwork index"];
            result = [tableView makeViewWithIdentifier:@"artworkId" owner:self];
            result.textField.integerValue = [(ArtworkEntity *)[self.artworksArray objectAtIndex:row] index];
            }
        else if ([[tableColumn identifier] isEqualToString:@"artworkName"])
            {
            NSLog(@"tableColumn = artworkName");
            [[tableCellView textField] setObjectValue:@"Artwork name"];
            result = [tableView makeViewWithIdentifier:@"artworkName" owner:self];
            result.textField.stringValue = [(ArtworkEntity *)[self.artworksArray objectAtIndex:row] name];
            }
        }
    return result;
    }

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
    {
    id returnValue=nil;
    ArtworkEntity *awe = (ArtworkEntity *)[self.artworksArray objectAtIndex:rowIndex];
    NSLog(@"ABArtworks: tableView.objectValueForTableColumn.row");
    if (awe != nil)
        {
        if ([[aTableColumn identifier] isEqualToString:@"artworkId"])
            returnValue = [[NSString alloc] initWithFormat:@"%d",[awe index]];
        else if ([[aTableColumn identifier] isEqualToString:@"artworkName"])
            returnValue = [awe name];
        }
    return returnValue;
    }

- (void)tableView:(NSTableView *)aTableView
   setObjectValue:(id)anObject
   forTableColumn:(NSTableColumn *)aTableColumn
              row:(NSInteger)rowIndex
    {
    NSLog(@"ABArtworks: tableView.setObjectValue.forTableColumn");
    }

- (void)tableView:(NSTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

    {
    NSLog(@"ABArtworks: tableView.didSelectRowAtIndexPath");
    }

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
    {
    NSTableView *tbv = [aNotification object];
    NSInteger iRow = [tbv selectedRow];
    NSLog(@"ABArtworks:tableViewSelectionDidChange row %ld", iRow);
    }

- (void)clear
    {
    NSLog(@"ABArtworks clear called");
    
    for (ArtworkEntity *awe in self.artworksArray)
        {
        if (awe != nil)
            {
            
            }
        }
    [self.artworksArray removeAllObjects];
    NSLog(@"ABArtworks clear exiting");
    }

- (void)appendArtworkWithId:(UInt16)uid withName:(NSString *)name
    {
    ArtworkEntity *awe = [[ArtworkEntity alloc] initWithId:uid withName:name];
    [self.artworksArray addObject:awe];
    //NSLog(@"ABArtworks appendArtworkWithId %@   %lu  count = %lu", awe, (unsigned long)uid, (unsigned long)[self.artworksArray count]);
    }

- (ArtworkEntity *)getArtworkAtIndex:(UInt16)iIndex
    {
    ArtworkEntity *pArtwork = nil;
    pArtwork = (ArtworkEntity *)[self.artworksArray objectAtIndex:iIndex];
    return pArtwork;
    }

- (void)dataReady:(NSNotification *)notification
    {
    NSLog(@"ABArtworks:dataReady");
    // Clear any previous list entries
    //cast obj to NSDictionary
    NSDictionary *result = (NSDictionary *)notification.object;
    
    NSLog(@"ABArtworks:dataReady result = %@", result);
    [self clear];
    if (result != nil)
        {
        for (NSDictionary *dict in result)
            {
            NSInteger uid = [[dict objectForKey:@"id"] intValue];
            NSString *name = [dict objectForKey:@"name"];
            [self appendArtworkWithId:uid withName:name];
            }
        [[NSNotificationCenter defaultCenter]
         postNotificationName:abApiNotifyArtworksReady
         object:self];
        
        }
    }

- (void)artworkJSONReady:(NSNotification *)notification
    {
    NSLog(@"ABArtwork:artworkJSONReady");
    //cast obj to NSDictionary
    NSDictionary *result = (NSDictionary *)notification.object;
    
    if (result != nil)
        {
        [self.artworkItem fromJSON:result];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:abApiNotifyArtworkReady
         object:self.artworkItem];
        
        }
    }



@end
