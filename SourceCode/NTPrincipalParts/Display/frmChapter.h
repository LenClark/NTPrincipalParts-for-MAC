//
//  frmChapter.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 21/01/2022.
//

#import <Cocoa/Cocoa.h>
#import "classBooks.h"
#import "classChapter.h"
#import "classVerse.h"
#import "classProcessing.h"

NS_ASSUME_NONNULL_BEGIN

@interface frmChapter : NSWindowController <NSTextViewDelegate>

@property (retain) IBOutlet NSWindow *chapterWindow;
@property (retain) NSWindowController *parentController;
@property (retain) NSWindowController *grandparentController;
@property (retain) IBOutlet NSTextView *txtChapter;

- (void) processReference: (NSString *) fullreference forBook: (NSString *) bookName andChapter: (NSString *) chapter including: (NSDictionary *) listOfBooks procsLoc: (classProcessing *) dispProcs;

@end

NS_ASSUME_NONNULL_END
