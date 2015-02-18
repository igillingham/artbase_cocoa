//
//  ABArtworks.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 15/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ABArtworks.h"

@implementation ABArtworks

-(id)init
    {
    NSLog(@"ABArtworks init");
    return [super init];
    }

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
    {
    NSLog(@"ABArtworks numberOfRowsInTableView");
    return([self.artworksArray count]);
    }

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
    {
    NSTableCellView *result;
    NSLog(@"ABArtworks viewForTableColumn");
    NSTableCellView *tableCellView = [tableView makeViewWithIdentifier:@"artworkTableView" owner:self];
    if ([[tableColumn identifier] isEqualToString:@"artworkIdCol"])
        {
        NSLog(@"tableColumn = artworkIdCol");
        [[tableCellView textField] setObjectValue:@"Artwork index"];
        result = [tableView makeViewWithIdentifier:@"artworkIdCol" owner:self];
        result.textField.stringValue = @"An artwork index";
        }
    else if ([[tableColumn identifier] isEqualToString:@"artworkName"])
             {
             NSLog(@"tableColumn = artworkName");
             [[tableCellView textField] setObjectValue:@"Artwork name"];
             result = [tableView makeViewWithIdentifier:@"artworkName" owner:self];
             result.textField.stringValue = @"An artwork name";
             }

    return result;
    }

- (void)clear
    {
    [self setArtworksArray:[[NSMutableArray alloc] init]];
    for (ArtworkEntity *awe in self.artworksArray)
        {
        if (awe != nil)
            {
            
            }
        }
    }

- (void)appendArtworkWithId:(UInt16)uid withName:(NSString *)name
    {
    ArtworkEntity *awe = [[ArtworkEntity alloc] initWithId:uid withName:name];
    [self.artworksArray addObject:awe];
    }

@end
