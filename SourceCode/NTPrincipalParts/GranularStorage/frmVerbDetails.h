//
//  frmVerbDetails.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 14/01/2022.
//

#import <Cocoa/Cocoa.h>
#import "classProcessing.h"
#import "classRoot.h"
#import "classParseDetail.h"
#import "frmReferences.h"

NS_ASSUME_NONNULL_BEGIN

@interface frmVerbDetails : NSWindowController <NSTableViewDelegate, NSTableViewDataSource>

@property (retain) IBOutlet NSWindow *verbDetailsWindow;
@property (retain) NSDictionary *listOfBooks;
@property (retain) classProcessing *detailsProcessing;
@property (retain) NSString *rootWord;
@property (retain) NSArray *titlesMaster;
@property (retain) NSMutableArray *titlesCol;
@property (retain) NSMutableArray *allCol1Master;
@property (retain) NSMutableArray *allColumn1;
@property (retain) NSMutableArray *allCol2Master;
@property (retain) NSMutableArray *allColumn2;
@property (retain) NSMutableArray *allParse1Master;
@property (retain) NSMutableArray *allParse1;
@property (retain) NSMutableArray *allParse2Master;
@property (retain) NSMutableArray *allParse2;
@property (retain) IBOutlet NSTableView *tvPresentActive;
@property (retain) IBOutlet NSTableView *tvPresentMiddle;
@property (retain) IBOutlet NSTableView *tvPresentPassive;
@property (retain) IBOutlet NSTableView *tvImperfectActive;
@property (retain) IBOutlet NSTableView *tvImperfectMiddle;
@property (retain) IBOutlet NSTableView *tvImperfectPassive;
@property (retain) IBOutlet NSTableView *tvFutureActive;
@property (retain) IBOutlet NSTableView *tvFutureMiddle;
@property (retain) IBOutlet NSTableView *tvAoristActive;
@property (retain) IBOutlet NSTableView *tvAoristMiddle;
@property (retain) IBOutlet NSTableView *tvPerfectActive;
@property (retain) IBOutlet NSTableView *tvPluperfectActive;
@property (retain) IBOutlet NSTableView *tvPerfectMiddle;
@property (retain) IBOutlet NSTableView *tvPluperfectMiddle;
@property (retain) IBOutlet NSTableView *tvPerfectPassive;
@property (retain) IBOutlet NSTableView *tvPluperfectPassive;
@property (retain) IBOutlet NSTableView *tvAoristPassive;
@property (retain) IBOutlet NSTableView *tvFuturePassive;
@property (retain) IBOutlet NSTabView *mainTabView;
@property (retain) IBOutlet NSTabView *subTabView1;
@property (retain) IBOutlet NSTabView *subTabView2;
@property (retain) IBOutlet NSTabView *subTabView3;
@property (retain) IBOutlet NSTabView *subTabView4;
@property (retain) IBOutlet NSTabView *subTabView5;
@property (retain) IBOutlet NSTabView *subTabView6;
@property (retain) IBOutlet NSButton *rbtnNoParticiples;
@property (retain) IBOutlet NSButton *rbtnSingleParticiple;
@property (retain) IBOutlet NSButton *rbtnAllParticiples;
@property (retain) IBOutlet NSButton *ckSubjunctives;
@property (retain) IBOutlet NSButton *ckPPart1;
@property (retain) IBOutlet NSButton *ckPPart2;
@property (retain) IBOutlet NSButton *ckPPart3;
@property (retain) IBOutlet NSButton *ckPPart4;
@property (retain) IBOutlet NSButton *ckPPart5;
@property (retain) IBOutlet NSButton *ckPPart6;
@property (retain) IBOutlet NSButton *btnSelect;

// References form
@property (retain) frmReferences *refForm;

- (void) initialiseDetails: (classRoot *) rootClass withBookList: (NSDictionary *) copyOfBookList andProcessClass: (classProcessing *) classProcs;

@end

NS_ASSUME_NONNULL_END
