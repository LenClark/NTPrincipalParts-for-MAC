//
//  AppDelegate.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import <Cocoa/Cocoa.h>
#import "classBooks.h"
#import "classProcessing.h"
#import "classRoot.h"
#import "classFrequency.h"
#import "frmVerbDetails.h"
#import "frmProgress.h"
#import "frmHelp.h"
#import "frmAbout.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource>

@property (retain) IBOutlet NSWindow *mainWindow;

// Managing progress reporting
@property (retain) NSRunLoop *mainLoop;
@property (retain) frmProgress *progressForm;

// Populating text - books, chapters and verses
@property (nonatomic) NSInteger noOfNTBooks;
@property (nonatomic) NSInteger noOfLXXBooks;
@property (nonatomic) NSInteger noOfStoredBooks;
@property (retain) NSMutableDictionary *listOfRoots;

// Objects on the main form
@property (retain) IBOutlet NSBox *vKeyboard;
@property (retain) NSMutableString *keyEntryworkspace;
@property (retain) IBOutlet NSTextField *selectionCriteriaLabel;

// Word list listbox
@property (retain) IBOutlet NSTableView *tvWordList;
@property (strong) NSMutableArray *wordListContents;
@property (retain) NSArray *masterWordList;
@property (retain) NSArray *masterDescWordList;
@property (retain) NSArray *masterAscWordList;

// Summary table
@property (retain) IBOutlet NSTableView *tvSummary;
@property (strong) NSMutableArray *summaryLabels;
@property (strong) NSMutableArray *summaryData;
@property (retain) IBOutlet NSTextField *SummaryWord;

// Verb Details form
@property (retain) frmVerbDetails *verbDetails;

// Frequency table
@property (retain) NSMutableDictionary *frequencyTable;
@property (nonatomic) bool isSortedOnDescending;
@property (nonatomic) bool isSortedOnAscending;

// Help
@property (retain) frmHelp *helpForm;
@property (retain) frmAbout *aboutForm;

@end

