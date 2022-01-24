//
//  frmReferences.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 20/01/2022.
//

#import <Cocoa/Cocoa.h>
#import "classProcessing.h"
#import "classReference.h"
#import "frmChapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface frmReferences : NSWindowController <NSTableViewDelegate, NSTableViewDataSource>

@property (retain) IBOutlet NSWindow *referenceWindow;
@property (retain) NSString *referencedWordForm;
@property (retain) NSWindowController *parentController;
@property (retain) NSDictionary *listOfBooks;
@property (retain) classProcessing *refProcs;
@property (retain) NSMutableArray *idList;
@property (retain) NSMutableDictionary *indexedBookName;
@property (retain) NSMutableDictionary *indexedChapter;
@property (retain) NSMutableDictionary *indexedFullRef;
@property (retain) NSMutableDictionary *indexedVerse;
@property (retain) NSMutableArray *column1;
@property (retain) NSMutableArray *column2;
@property (retain) NSMutableArray *column3;
@property (retain) IBOutlet NSTableView *tvReferences;
@property (retain) frmChapter *chapterDisplay;

- (void) displayReferences: (NSDictionary *) referenceList forTheWordForm: (NSString *) wordForm usingBookList: (NSDictionary *) inListOfBooks withProcessesIn: (classProcessing *) inRefProcs;

@end

NS_ASSUME_NONNULL_END
