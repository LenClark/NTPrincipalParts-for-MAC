//
//  frmVerbDetails.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 14/01/2022.
//

#import "frmVerbDetails.h"

@interface frmVerbDetails ()

@end

@implementation frmVerbDetails

@synthesize verbDetailsWindow;
@synthesize listOfBooks;
@synthesize detailsProcessing;
@synthesize rootWord;

@synthesize titlesMaster;
@synthesize titlesCol;
@synthesize allCol1Master;
@synthesize allColumn1;
@synthesize allCol2Master;
@synthesize allColumn2;
@synthesize allParse1Master;
@synthesize allParse1;
@synthesize allParse2Master;
@synthesize allParse2;

@synthesize tvPresentActive;
@synthesize tvPresentMiddle;
@synthesize tvPresentPassive;
@synthesize tvImperfectActive;
@synthesize tvImperfectMiddle;
@synthesize tvImperfectPassive;
@synthesize tvFutureActive;
@synthesize tvFutureMiddle;
@synthesize tvAoristActive;
@synthesize tvAoristMiddle;
@synthesize tvPerfectActive;
@synthesize tvPluperfectActive;
@synthesize tvPerfectMiddle;
@synthesize tvPluperfectMiddle;
@synthesize tvPerfectPassive;
@synthesize tvPluperfectPassive;
@synthesize tvAoristPassive;
@synthesize tvFuturePassive;
@synthesize refForm;
@synthesize mainTabView;
@synthesize subTabView1;
@synthesize subTabView2;
@synthesize subTabView3;
@synthesize subTabView4;
@synthesize subTabView5;
@synthesize subTabView6;
@synthesize rbtnNoParticiples;
@synthesize rbtnSingleParticiple;
@synthesize rbtnAllParticiples;
@synthesize ckSubjunctives;
@synthesize ckPPart1;
@synthesize ckPPart2;
@synthesize ckPPart3;
@synthesize ckPPart4;
@synthesize ckPPart5;
@synthesize ckPPart6;
@synthesize btnSelect;

const NSInteger noOfTables = 18; // Total number of tabs

/*=====================================================================================================*
 *                                                                                                     *
 *                                        initialisation variables                                     *
 *                                        ========================                                     *
 *                                                                                                     *
 *  Variables controlling the storage and retrieval of values from one session to another              *
 *                                                                                                     *
 *  whatToShow: This variable retains the last selection choice (participles and Subjunctive/Optative) *
 *              and has the following valaues:                                                         *
 *                Code         Participles option              Subjunctive/Optative option             *
 *                 1      No participle information         No subjunctives or optatives shown         *
 *                 2      Only Masc. Sing. participle shown No subjunctives or optatives shown         *
 *                 3      All participle information        No subjunctives or optatives shown         *
 *                 5      No participle information         Subjunctives or optatives are shown        *
 *                 6      Only Masc. Sing. participle shown Subjunctives or optatives are shown        *
 *                 7      All participle information        Subjunctives or optatives are shown        *
 *                                                                                                     *
 *=====================================================================================================*/

NSInteger whatToShow;
NSString *basePath, *lfcFolder, *appFolder, *initFileName, *initPath;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void) awakeFromNib
{
    BOOL isDir;
    NSInteger tempOptionCode;
    NSString *initContents, *initKey;
    NSArray *fileLines, *lineContent;
    NSFileManager *fmInit;

    [tvPresentActive setTarget:self];
    [tvPresentMiddle setTarget:self];
    [tvPresentPassive setTarget:self];
    [tvImperfectActive setTarget:self];
    [tvImperfectMiddle setTarget:self];
    [tvImperfectPassive setTarget:self];
    [tvFutureActive setTarget:self];
    [tvFutureMiddle setTarget:self];
    [tvAoristActive setTarget:self];
    [tvAoristMiddle setTarget:self];
    [tvPerfectActive setTarget:self];
    [tvPluperfectActive setTarget:self];
    [tvPerfectMiddle setTarget:self];
    [tvPluperfectMiddle setTarget:self];
    [tvPerfectPassive setTarget:self];
    [tvPluperfectPassive setTarget:self];
    [tvAoristPassive setTarget:self];
    [tvFuturePassive setTarget:self];
    [tvPresentActive setDoubleAction:@selector(doubleClick:)];
     [tvPresentMiddle setDoubleAction:@selector(doubleClick:)];
     [tvPresentPassive setDoubleAction:@selector(doubleClick:)];
     [tvImperfectActive setDoubleAction:@selector(doubleClick:)];
     [tvImperfectMiddle setDoubleAction:@selector(doubleClick:)];
     [tvImperfectPassive setDoubleAction:@selector(doubleClick:)];
     [tvFutureActive setDoubleAction:@selector(doubleClick:)];
     [tvFutureMiddle setDoubleAction:@selector(doubleClick:)];
     [tvAoristActive setDoubleAction:@selector(doubleClick:)];
     [tvAoristMiddle setDoubleAction:@selector(doubleClick:)];
     [tvPerfectActive setDoubleAction:@selector(doubleClick:)];
     [tvPluperfectActive setDoubleAction:@selector(doubleClick:)];
     [tvPerfectMiddle setDoubleAction:@selector(doubleClick:)];
     [tvPluperfectMiddle setDoubleAction:@selector(doubleClick:)];
     [tvPerfectPassive setDoubleAction:@selector(doubleClick:)];
     [tvPluperfectPassive setDoubleAction:@selector(doubleClick:)];
     [tvAoristPassive setDoubleAction:@selector(doubleClick:)];
     [tvFuturePassive setDoubleAction:@selector(doubleClick:)];

    /*-----------------------------------------------------------------------------------------------------*
     *                                                                                                     *
     *  Main source/storage locations                                                                      *
     *  -----------------------------                                                                      *
     *                                                                                                     *
     *  Initialisation data (retained from session to session) will be stored in: "~/LFCConsulting/GBS.    *
     *                                                                                                     *
     *-----------------------------------------------------------------------------------------------------*/

    whatToShow = 1;  // Default value
    isDir = true;
    fmInit = [NSFileManager defaultManager];
    initPath = [[NSString alloc] initWithFormat:@"%@%@%@/%@", [fmInit homeDirectoryForCurrentUser], basePath, lfcFolder, appFolder];
    if( [initPath containsString:@"file:///"] ) initPath = [[NSString alloc] initWithString:[initPath substringFromIndex:7]];
    initFileName = [[NSString alloc] initWithFormat:@"%@/init.dat", initPath];
    if( [fmInit fileExistsAtPath:initPath isDirectory:&isDir])
    {
        initContents = [[NSString alloc] initWithContentsOfFile:initFileName encoding:NSUTF8StringEncoding error:nil];
        fileLines = [initContents componentsSeparatedByString:@"\n"];
        for (NSString *actualLine in fileLines)
        {
            if(( actualLine == nil ) || ( [actualLine length] == 0 ) ) continue;
            lineContent = [actualLine componentsSeparatedByString:@"="];
            initKey = [[NSString alloc] initWithString:[lineContent objectAtIndex:0]];
            if( [initKey compare:@"What to show"] == NSOrderedSame ) whatToShow = [[lineContent objectAtIndex:1] integerValue];
        }
    }
    else
    {
        [fmInit createDirectoryAtPath:initPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    tempOptionCode = whatToShow;
    if( tempOptionCode > 4)
    {
        tempOptionCode = whatToShow - 4;
        [ckSubjunctives setState:NSControlStateValueOn];
    }
    switch (tempOptionCode)
    {
        case 1:
            [rbtnNoParticiples setState:NSControlStateValueOn];
            [rbtnSingleParticiple setState:NSControlStateValueOff];
            [rbtnAllParticiples setState:NSControlStateValueOff];
            break;
        case 2:
            [rbtnNoParticiples setState:NSControlStateValueOff];
            [rbtnSingleParticiple setState:NSControlStateValueOn];
            [rbtnAllParticiples setState:NSControlStateValueOff];
            break;
        case 3:
            [rbtnNoParticiples setState:NSControlStateValueOff];
            [rbtnSingleParticiple setState:NSControlStateValueOff];
            [rbtnAllParticiples setState:NSControlStateValueOn];
            break;
        default: break;
    }
}

- (void) initialiseDetails: (classRoot *) rootClass withBookList: (NSDictionary *) copyOfBookList andProcessClass: (classProcessing *) classProcs
{
    NSInteger idx, pdx, noOfColumns, maxRows, wordCount, rowPosition = 0, colPosition = 0, tableNo, breakdownElement;
    NSString *parseCodeKey, *windowTitle;
    NSMutableString *cellEntry;
    NSMutableAttributedString *finalDisplay;
    NSArray *localBreakdown;
    NSMutableArray *currentCol, *parseCol;
    NSDictionary *parseCopy;
    NSColor *normalColor, *redColour, *greyColour;
    NSFont *italicFont, *normalFont;
    classParseDetail *currentParse;
    
    basePath = @"/Library/";
    lfcFolder = @"LFCConsulting";
    appFolder = @"NTPrincipalParts";

    normalColor = [NSColor colorWithRed:0 green:0 blue:0 alpha:1];
    redColour = [NSColor colorWithRed:1 green:0 blue:0 alpha:1];
    greyColour = [NSColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    normalFont = [NSFont fontWithName:@"Times New Roman" size:16];
    italicFont = [NSFont fontWithName:@"Times New Roman Italic" size:16];
    listOfBooks = [[NSDictionary alloc] initWithDictionary:copyOfBookList];
    detailsProcessing = classProcs;
    noOfColumns = 12;
    titlesMaster = [[NSArray alloc] initWithObjects: @"First person", @"Second person", @"Third person", @"", @"Imperative", @"", @"Infinitive", @"",
                                @"Participles:", @"   Masculine Nominative", @"   Vocative", @"   Accusative", @"   Genitive", @"   Dative", @"",
                                @"   Neuter Nominative", @"   Vocative", @"   Accusative", @"   Genitive", @"   Dative", @"",
                                @"   Feminine Nominative", @"   Vocative", @"   Accusative", @"   Genitive", @"   Dative", @"",
                                @"Subjunctive:", @"   First person", @"   Second person", @"   Third person", @"",
                                @"Optative:", @"   First person", @"   Second person", @"   Third person", nil];
    titlesCol = [[NSMutableArray alloc] initWithArray:titlesMaster];
    maxRows = [titlesMaster count];
    parseCopy = [[NSDictionary alloc] initWithDictionary:[rootClass parsedDetails]];
    
    rootWord = [[NSString alloc] initWithString:[rootClass rootWord]];
    windowTitle = [[NSString alloc] initWithFormat:@"Principal parts for the verb: %@", rootWord];
    [[self window] setTitle:windowTitle];
    allCol1Master = [[NSMutableArray alloc] initWithCapacity:noOfTables];
    allCol2Master = [[NSMutableArray alloc] initWithCapacity:noOfTables];
    allParse1Master = [[NSMutableArray alloc] initWithCapacity:noOfTables];
    allParse2Master = [[NSMutableArray alloc] initWithCapacity:noOfTables];
    for( pdx = 0; pdx < noOfTables; pdx++)
    {
        [allCol1Master addObject:@""];
        [allCol2Master addObject:@""];
        [allParse1Master addObject:@""];
        [allParse2Master addObject:@""];    }
    for( pdx = 0; pdx < noOfTables; pdx++)
    {
        currentCol = [[NSMutableArray alloc] init];
        parseCol = [[NSMutableArray alloc] init];
        for( idx = 0; idx < maxRows; idx++)
        {
            [currentCol addObject:@""];
            [parseCol addObject:@""];
        }
        [allCol1Master replaceObjectAtIndex:pdx withObject:currentCol];
        [allParse1Master replaceObjectAtIndex:pdx withObject:parseCol];
    }
    for( pdx = 0; pdx < noOfTables; pdx++)
    {
        currentCol = [[NSMutableArray alloc] init];
        parseCol = [[NSMutableArray alloc] init];
        for( idx = 0; idx < maxRows; idx++)
        {
            [currentCol addObject:@""];
            [parseCol addObject:@""];
        }
        [allCol2Master replaceObjectAtIndex:pdx withObject:currentCol];
        [allParse2Master replaceObjectAtIndex:pdx withObject:parseCol];
    }
    for( parseCodeKey in parseCopy)
    {
        colPosition = 0;
        rowPosition = 0;
        tableNo = 0;
        currentParse = [parseCopy objectForKey:parseCodeKey];
        localBreakdown = [[NSArray alloc] initWithArray:[currentParse grammarBreakdown]];
        breakdownElement = [[localBreakdown objectAtIndex:5] integerValue];  // Mood
        switch (breakdownElement)
        {
            case 1: rowPosition = 0; break;  // Indicative
            case 2: rowPosition = 4; break;  // Imperative
            case 3: rowPosition = 28; break; // Subjunctive
            case 4: rowPosition = 33; break; // Optative
            case 5: rowPosition = 6; break;  // Infinitive
            case 6: rowPosition = 9; break;  // Participle
            default: break;
        }
        breakdownElement = [[localBreakdown objectAtIndex:0] integerValue];  // Person
        switch (breakdownElement)
        {
            case 2:
                if( [[localBreakdown objectAtIndex:5] integerValue] != 2 ) rowPosition++;
                break;    // 2nd person - row 1 (0-based)
            case 3: rowPosition += 2; break; // 3rd person - row 2
            default: break;
        }
        breakdownElement = [[localBreakdown objectAtIndex:3] integerValue];  // Gender - will only function for participles
        switch (breakdownElement)
        {
            case 2: rowPosition += 6; break;
            case 3: rowPosition += 12; break;
            default: break;
        }
        breakdownElement = [[localBreakdown objectAtIndex:2] integerValue];  // Case - will only function for participles
        switch (breakdownElement)
        {
            case 2: rowPosition++; break;
            case 3: rowPosition += 2; break;
            case 4: rowPosition += 3; break;
            case 5: rowPosition += 4; break;
            default: break;
        }
        breakdownElement = [[localBreakdown objectAtIndex:4] integerValue];  // Tense - a bit more complex
        switch (breakdownElement)
        {
            case 1:  // Present (tables 0, 2 or 4)
                breakdownElement = [[localBreakdown objectAtIndex:6] integerValue];
                switch (breakdownElement)
                {
                    case 1: tableNo = 0; break;
                    case 2: tableNo = 2; break;
                    case 3: tableNo = 4; break;
                    default: break;
                } break;
            case 2:  // Imperfect (tables 1, 3 or 5)
                breakdownElement = [[localBreakdown objectAtIndex:6] integerValue];
                switch (breakdownElement)
                {
                    case 1: tableNo = 1; break;
                    case 2: tableNo = 3; break;
                    case 3: tableNo = 5; break;
                    default: break;
                } break;
            case 3:  // Aorist (tables8, 9 or 16)
                breakdownElement = [[localBreakdown objectAtIndex:6] integerValue];
                switch (breakdownElement)
                {
                    case 1: tableNo = 8; break;
                    case 2: tableNo = 9; break;
                    case 3: tableNo = 16; break;
                    default: break;
                } break;
            case 4:  // Perfect - (tables 10, 12 or 14)
                breakdownElement = [[localBreakdown objectAtIndex:6] integerValue];
                switch (breakdownElement)
                {
                    case 1: tableNo = 10; break;
                    case 2: tableNo = 12; break;
                    case 3: tableNo = 14; break;
                    default: break;
                } break;
            case 5:  // Pluperfect - ( tables 11, 13 or 15)
                breakdownElement = [[localBreakdown objectAtIndex:6] integerValue];
                switch (breakdownElement)
                {
                    case 1: tableNo = 11; break;
                    case 2: tableNo = 13; break;
                    case 3: tableNo = 15; break;
                    default: break;
                } break;
           case 6:  // Future - (tables 6, 7 or 17)
                breakdownElement = [[localBreakdown objectAtIndex:6] integerValue];
                switch (breakdownElement)
                {
                    case 1: tableNo = 6; break;
                    case 2: tableNo = 7; break;
                    case 3: tableNo = 17; break;
                    default: break;
                } break;
            default: break;
        }
        breakdownElement = [[localBreakdown objectAtIndex:1] integerValue];  // Number (singular or plural - affects columns
        switch (breakdownElement)
        {
            case 1: colPosition = 0; break;
            case 2: colPosition = 1; break;
            default: break;
        }
        cellEntry = [[NSMutableString alloc] initWithString:@""];
        wordCount = [currentParse cleanWordCount];
        for( idx = 0; idx < wordCount; idx++)
        {
            if( idx == 0 ) [cellEntry appendString:[[currentParse actualWordForms] objectAtIndex:idx]];
            else [cellEntry appendFormat:@", %@",[[currentParse actualWordForms] objectAtIndex:idx]];
        }
        if( colPosition == 0 )
        {
            currentCol = [allCol1Master objectAtIndex:tableNo];
            parseCol = [allParse1Master objectAtIndex:tableNo];
        }
        else
        {
            currentCol = [allCol2Master objectAtIndex:tableNo];
            parseCol = [allParse2Master objectAtIndex:tableNo];
        }
        finalDisplay = [[NSMutableAttributedString alloc] initWithString:[detailsProcessing cleanWord: cellEntry]];
        switch ([currentParse ntAndLxxCode]) {
            case 1:
                [finalDisplay addAttribute:NSForegroundColorAttributeName value:normalColor range:(NSMakeRange(0, [cellEntry length]))];
                [finalDisplay addAttribute:NSFontAttributeName value:normalFont range:(NSMakeRange(0, [cellEntry length]))];
                break;
            case 2:
                [finalDisplay addAttribute:NSForegroundColorAttributeName value:greyColour range:(NSMakeRange(0, [cellEntry length]))];
                [finalDisplay addAttribute:NSFontAttributeName value:italicFont range:(NSMakeRange(0, [cellEntry length]))];
                break;
            case 3:
                [finalDisplay addAttribute:NSForegroundColorAttributeName value:redColour range:(NSMakeRange(0, [cellEntry length]))];
                [finalDisplay addAttribute:NSFontAttributeName value:italicFont range:(NSMakeRange(0, [cellEntry length]))];
                break;

            default:
                break;
        }
        [currentCol replaceObjectAtIndex:rowPosition withObject:finalDisplay];
        [parseCol replaceObjectAtIndex:rowPosition withObject:[currentParse referenceList]];
    }
    [self populateFinalTables];
}

- (void) populateFinalTables
{
    BOOL isDir;
    NSInteger idx, jdx, buttonCode = 0, noOfRows = 0;
    NSMutableArray *currentMasterCol, *currentCol, *parseMasterCol, *parseCol;
    NSMutableString *initContents;
    NSFileManager *fmInit;

    if( [rbtnNoParticiples state] == NSControlStateValueOn) buttonCode = 1;
    if( [rbtnSingleParticiple state] == NSControlStateValueOn) buttonCode = 2;
    if( [rbtnAllParticiples state] == NSControlStateValueOn) buttonCode = 3;
    [titlesCol removeAllObjects];
    allColumn1 = [[NSMutableArray alloc] init];
    allColumn2 = [[NSMutableArray alloc] init];
    allParse1 = [[NSMutableArray alloc] init];
    allParse2 = [[NSMutableArray alloc] init];
    switch (buttonCode)
    {
        case 1: noOfRows = 7; break;
        case 2: noOfRows = 10; break;
        case 3: noOfRows = 26; break;
        default: break;
    }
    for( idx = 0; idx < noOfRows; idx++)
    {
        [titlesCol addObject:[titlesMaster objectAtIndex:idx]];
    }
    for( jdx = 0; jdx < noOfTables; jdx++)
    {
        currentMasterCol = [[NSMutableArray alloc] initWithArray:[allCol1Master objectAtIndex:jdx]];
        parseMasterCol = [[NSMutableArray alloc] initWithArray:[allParse1Master objectAtIndex:jdx]];
        currentCol = [[NSMutableArray alloc] init];
        parseCol = [[NSMutableArray alloc] init];
        for( idx = 0; idx < noOfRows; idx++)
        {
            [currentCol addObject:[currentMasterCol objectAtIndex:idx]];
            [parseCol addObject:[parseMasterCol objectAtIndex:idx]];
        }
        [allColumn1 addObject:currentCol];
        [allParse1 addObject:parseCol];
    }
    for( jdx = 0; jdx < noOfTables; jdx++)
    {
        currentMasterCol = [[NSMutableArray alloc] initWithArray:[allCol2Master objectAtIndex:jdx]];
        parseMasterCol = [[NSMutableArray alloc] initWithArray:[allParse2Master objectAtIndex:jdx]];
        currentCol = [[NSMutableArray alloc] init];
        parseCol = [[NSMutableArray alloc] init];
        for( idx = 0; idx < noOfRows; idx++)
        {
            [currentCol addObject:[currentMasterCol objectAtIndex:idx]];
            [parseCol addObject:[parseMasterCol objectAtIndex:idx]];
        }
        [allColumn2 addObject:currentCol];
        [allParse2 addObject:parseCol];
    }
    if( [ckSubjunctives state] == NSControlStateValueOn)
    {
        for( idx = 26; idx < 36; idx++)
        {
            [titlesCol addObject:[titlesMaster objectAtIndex:idx]];
        }
        for( jdx = 0; jdx < noOfTables; jdx++)
        {
            currentMasterCol = [[NSMutableArray alloc] initWithArray:[allCol1Master objectAtIndex:jdx]];
            parseMasterCol = [[NSMutableArray alloc] initWithArray:[allParse1Master objectAtIndex:jdx]];
            currentCol = [[NSMutableArray alloc] initWithArray:[allColumn1 objectAtIndex:jdx]];
            parseCol = [[NSMutableArray alloc] initWithArray:[allParse1 objectAtIndex:jdx]];
            for( idx = 26; idx < 36; idx++)
            {
                [currentCol addObject:[currentMasterCol objectAtIndex:idx]];
                [parseCol addObject:[parseMasterCol objectAtIndex:idx]];
            }
            [allColumn1 replaceObjectAtIndex:jdx withObject:currentCol];
            [allParse1 replaceObjectAtIndex:jdx withObject:parseCol];
        }
        for( jdx = 0; jdx < noOfTables; jdx++)
        {
            currentMasterCol = [[NSMutableArray alloc] initWithArray:[allCol2Master objectAtIndex:jdx]];
            parseMasterCol = [[NSMutableArray alloc] initWithArray:[allParse2Master objectAtIndex:jdx]];
            currentCol = [[NSMutableArray alloc] initWithArray:[allColumn2 objectAtIndex:jdx]];
            parseCol = [[NSMutableArray alloc] initWithArray:[allParse2 objectAtIndex:jdx]];
            for( idx = 26; idx < 36; idx++)
            {
                [currentCol addObject:[currentMasterCol objectAtIndex:idx]];
                [parseCol addObject:[parseMasterCol objectAtIndex:idx]];
            }
            [allColumn2 replaceObjectAtIndex:jdx withObject:currentCol];
            [allParse2 replaceObjectAtIndex:jdx withObject:parseCol];
        }
        // Update the value of whatToShow
        whatToShow = 4 + buttonCode;
    }
    else whatToShow = buttonCode;
    fmInit = [NSFileManager defaultManager];
    isDir = false;
    if( [fmInit fileExistsAtPath:initFileName isDirectory:&isDir]) [fmInit removeItemAtPath:initFileName error:nil];
    initContents = [[NSMutableString alloc] initWithFormat:@"What to show=%li", whatToShow];
    [initContents writeToFile:initFileName atomically:YES encoding:NSUTF8StringEncoding error:nil];

    // We have built the master tables for _all_ forms.  Now the tables to be presented
    [tvPresentActive reloadData];
    [tvPresentMiddle reloadData];
    [tvPresentPassive reloadData];
    [tvImperfectActive reloadData];
    [tvImperfectMiddle reloadData];
    [tvImperfectPassive reloadData];
    [tvFutureActive reloadData];
    [tvFutureMiddle reloadData];
    [tvAoristActive reloadData];
    [tvAoristMiddle reloadData];
    [tvPerfectActive reloadData];
    [tvPluperfectActive reloadData];
    [tvPerfectMiddle reloadData];
    [tvPluperfectMiddle reloadData];
    [tvPerfectPassive reloadData];
    [tvPluperfectPassive reloadData];
    [tvAoristPassive reloadData];
    [tvFuturePassive reloadData];
}

- (IBAction)doParticipleOption:(NSButton *)sender
{
    NSButton *selectedButton;
    
    selectedButton = sender;
    if( [selectedButton state] == NSControlStateValueOn )
    {
        [self populateFinalTables];
    }
}

- (IBAction)doSubjunctiveOption:(id)sender
{
    [self populateFinalTables];
}

- (IBAction)doSelectPrintOptions:(NSButton *)sender
{
    NSString *caption;
    
    caption = [[NSString alloc] initWithString:[btnSelect title]];
    if( [caption compare:@"Select All"] == NSOrderedSame )
    {
        [ckPPart1 setState:NSControlStateValueOn];
        [ckPPart2 setState:NSControlStateValueOn];
        [ckPPart3 setState:NSControlStateValueOn];
        [ckPPart4 setState:NSControlStateValueOn];
        [ckPPart5 setState:NSControlStateValueOn];
        [ckPPart6 setState:NSControlStateValueOn];
        [sender setTitle:@"Deselect All"];
    }
    else
    {
        [ckPPart1 setState:NSControlStateValueOff];
        [ckPPart2 setState:NSControlStateValueOff];
        [ckPPart3 setState:NSControlStateValueOff];
        [ckPPart4 setState:NSControlStateValueOff];
        [ckPPart5 setState:NSControlStateValueOff];
        [ckPPart6 setState:NSControlStateValueOff];
        [sender setTitle:@"Select All"];
    }
}

- (IBAction)doHandlePrintChecks:(id)sender
{
    NSInteger onCount = 0;
    if([ckPPart1 state] == NSControlStateValueOn) onCount++;
    if([ckPPart2 state] == NSControlStateValueOn) onCount++;
    if([ckPPart3 state] == NSControlStateValueOn) onCount++;
    if([ckPPart4 state] == NSControlStateValueOn) onCount++;
    if([ckPPart5 state] == NSControlStateValueOn) onCount++;
    if([ckPPart6 state] == NSControlStateValueOn) onCount++;
    if( onCount == 6 ) [btnSelect setTitle:@"Deselect All"];
    else [btnSelect setTitle:@"Select All"];
}

- (IBAction)doSaveCSV:(id)sender
{
    bool isFirstFlag;
    NSUInteger idx, jdx, rowIdx, totalRows, saveRes;
    NSSavePanel *savePanel;
    NSString *startingDirectory, *fileName, *extension, *testName;
    NSMutableString *nameBase, *workingSpace, *outputData;
    NSArray *allowedFileTypes, *nameDecomposition, *newData;
    NSMutableArray *part1, *part2, *part3, *part4, *part5, *part6;
    NSURL *resultingLoc, *startingLoc;
    NSError *error;

    allowedFileTypes = [[NSArray alloc] initWithObjects:@"csv", @"txt", @"doc", nil];
    startingDirectory = [[NSString alloc] initWithString:[@"~" stringByExpandingTildeInPath]];
    startingLoc = [[NSURL alloc] initFileURLWithPath:startingDirectory];
    savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:[[NSString alloc] initWithFormat:@"%@_Paradigm.csv", rootWord]];
    [savePanel setAllowsOtherFileTypes:true];
    [savePanel setMessage:@"Select where you want to save the file, then click on \"Save\""];
    [savePanel setCanCreateDirectories:true];
    [savePanel setTitle:[[NSString alloc] initWithFormat:@"Save the NT and LXX paradigm for %@ in CSV format", rootWord]];
    [savePanel setDirectoryURL:startingLoc];
    saveRes = [savePanel runModal];
    if( saveRes == NSModalResponseOK )
    {
        resultingLoc = [savePanel URL];
        fileName = [[NSString alloc] initWithString:[resultingLoc path]];
        nameDecomposition = [fileName componentsSeparatedByString:@"."];
        nameBase = [[NSMutableString alloc] initWithString:@""];
        jdx = [nameDecomposition count];
        for( idx = 0; idx < jdx - 1; idx++)
        {
            if( idx == 0 ) [nameBase appendString:[nameDecomposition objectAtIndex:0]];
            else [nameBase appendFormat:@".%@", [nameDecomposition objectAtIndex:idx]];
        }
        extension = [[NSString alloc] initWithString:[nameDecomposition objectAtIndex:jdx - 1]];
        fileName = [[NSString alloc] initWithString:nameBase];
        totalRows = [titlesCol count];
        outputData = [[NSMutableString alloc] initWithString:@""];
        for( idx = 0; idx < 6; idx++ )
        {
            switch (idx)
            {
                case 0:
                    if( [ckPPart1 state] == NSControlStateValueOff) continue;
                    part1 = [[NSMutableArray alloc] init];
                    for( jdx = 0; jdx < 6; jdx++ )
                    {
                        isFirstFlag = ( jdx == 0 );
                        newData = [[NSArray alloc] initWithArray:[self storeData:jdx isLeadingTable:isFirstFlag]];
                        if( isFirstFlag) part1 = [[NSMutableArray alloc] initWithArray:newData];
                        else
                        {
                            for( rowIdx = 0; rowIdx < totalRows; rowIdx++ )
                            {
                                workingSpace = [[NSMutableString alloc] initWithString:[part1 objectAtIndex:rowIdx]];
                                [workingSpace appendFormat:@"\t%@", [newData objectAtIndex:rowIdx]];
                                [part1 replaceObjectAtIndex:rowIdx withObject:workingSpace];
                            }
                        }
                    }
                    testName = [[NSString alloc] initWithFormat:@"%@_Part1.%@", fileName, extension];
                    for( rowIdx = 0; rowIdx < totalRows; rowIdx++)
                    {
                        if( rowIdx == 0 ) outputData = [[NSMutableString alloc] initWithString:[part1 objectAtIndex:rowIdx]];
                        else [outputData appendFormat:@"\n%@", [part1 objectAtIndex:rowIdx]];
                    }
                    [outputData writeToFile:[[NSString alloc] initWithString:testName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    break;
                case 1:
                    if( [ckPPart2 state] == NSControlStateValueOff) continue;
                    part2 = [[NSMutableArray alloc] init];
                    for( jdx = 6; jdx < 8; jdx++ )
                    {
                        isFirstFlag = ( jdx == 6 );
                        newData = [[NSArray alloc] initWithArray:[self storeData:jdx isLeadingTable:isFirstFlag]];
                        if( isFirstFlag) part2 = [[NSMutableArray alloc] initWithArray:newData];
                        else
                        {
                            for( rowIdx = 0; rowIdx < totalRows; rowIdx++ )
                            {
                                workingSpace = [[NSMutableString alloc] initWithString:[part2 objectAtIndex:rowIdx]];
                                [workingSpace appendFormat:@"\t%@", [newData objectAtIndex:rowIdx]];
                                [part2 replaceObjectAtIndex:rowIdx withObject:workingSpace];
                            }
                        }
                    }
                    testName = [[NSString alloc] initWithFormat:@"%@_Part2.%@", fileName, extension];
                    for( rowIdx = 0; rowIdx < totalRows; rowIdx++)
                    {
                        if( rowIdx == 0 ) outputData = [[NSMutableString alloc] initWithString:[part2 objectAtIndex:rowIdx]];
                        else [outputData appendFormat:@"\n%@", [part2 objectAtIndex:rowIdx]];
                    }
                    [outputData writeToFile:[[NSString alloc] initWithString:testName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    break;
                case 2:
                    if( [ckPPart3 state] == NSControlStateValueOff) continue;
                    part3 = [[NSMutableArray alloc] init];
                    for( jdx = 8; jdx < 10; jdx++ )
                    {
                        isFirstFlag = ( jdx == 8 );
                        newData = [[NSArray alloc] initWithArray:[self storeData:jdx isLeadingTable:isFirstFlag]];
                        if( isFirstFlag) part3 = [[NSMutableArray alloc] initWithArray:newData];
                        else
                        {
                            for( rowIdx = 0; rowIdx < totalRows; rowIdx++ )
                            {
                                workingSpace = [[NSMutableString alloc] initWithString:[part3 objectAtIndex:rowIdx]];
                                [workingSpace appendFormat:@"\t%@", [newData objectAtIndex:rowIdx]];
                                [part3 replaceObjectAtIndex:rowIdx withObject:workingSpace];
                            }
                        }
                    }
                    testName = [[NSString alloc] initWithFormat:@"%@_Part3.%@", fileName, extension];
                    for( rowIdx = 0; rowIdx < totalRows; rowIdx++)
                    {
                        if( rowIdx == 0 ) outputData = [[NSMutableString alloc] initWithString:[part3 objectAtIndex:rowIdx]];
                        else [outputData appendFormat:@"\n%@", [part3 objectAtIndex:rowIdx]];
                    }
                    [outputData writeToFile:[[NSString alloc] initWithString:testName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    break;
                case 3:
                    if( [ckPPart4 state] == NSControlStateValueOff) continue;
                    part4 = [[NSMutableArray alloc] init];
                    for( jdx = 10; jdx < 12; jdx++ )
                    {
                        isFirstFlag = ( jdx == 10 );
                        newData = [[NSArray alloc] initWithArray:[self storeData:jdx isLeadingTable:isFirstFlag]];
                        if( isFirstFlag) part4 = [[NSMutableArray alloc] initWithArray:newData];
                        else
                        {
                            for( rowIdx = 0; rowIdx < totalRows; rowIdx++ )
                            {
                                workingSpace = [[NSMutableString alloc] initWithString:[part4 objectAtIndex:rowIdx]];
                                [workingSpace appendFormat:@"\t%@", [newData objectAtIndex:rowIdx]];
                                [part4 replaceObjectAtIndex:rowIdx withObject:workingSpace];
                            }
                        }
                    }
                    testName = [[NSString alloc] initWithFormat:@"%@_Part4.%@", fileName, extension];
                    for( rowIdx = 0; rowIdx < totalRows; rowIdx++)
                    {
                        if( rowIdx == 0 ) outputData = [[NSMutableString alloc] initWithString:[part4 objectAtIndex:rowIdx]];
                        else [outputData appendFormat:@"\n%@", [part4 objectAtIndex:rowIdx]];
                    }
                    [outputData writeToFile:[[NSString alloc] initWithString:testName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    break;
                case 4:
                    if( [ckPPart5 state] == NSControlStateValueOff) continue;
                    part5 = [[NSMutableArray alloc] init];
                    for( jdx = 12; jdx < 16; jdx++ )
                    {
                        isFirstFlag = ( jdx == 12 );
                        newData = [[NSArray alloc] initWithArray:[self storeData:jdx isLeadingTable:isFirstFlag]];
                        if( isFirstFlag) part5 = [[NSMutableArray alloc] initWithArray:newData];
                        else
                        {
                            for( rowIdx = 0; rowIdx < totalRows; rowIdx++ )
                            {
                                workingSpace = [[NSMutableString alloc] initWithString:[part5 objectAtIndex:rowIdx]];
                                [workingSpace appendFormat:@"\t%@", [newData objectAtIndex:rowIdx]];
                                [part5 replaceObjectAtIndex:rowIdx withObject:workingSpace];
                            }
                        }
                    }
                    testName = [[NSString alloc] initWithFormat:@"%@_Part5.%@", fileName, extension];
                    for( rowIdx = 0; rowIdx < totalRows; rowIdx++)
                    {
                        if( rowIdx == 0 ) outputData = [[NSMutableString alloc] initWithString:[part5 objectAtIndex:rowIdx]];
                        else [outputData appendFormat:@"\n%@", [part5 objectAtIndex:rowIdx]];
                    }
                    [outputData writeToFile:[[NSString alloc] initWithString:testName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    break;
                case 5:
                    if( [ckPPart6 state] == NSControlStateValueOff) continue;
                    part6 = [[NSMutableArray alloc] init];
                    for( jdx = 16; jdx < 18; jdx++ )
                    {
                        isFirstFlag = ( jdx == 16 );
                        newData = [[NSArray alloc] initWithArray:[self storeData:jdx isLeadingTable:isFirstFlag]];
                        if( isFirstFlag) part6 = [[NSMutableArray alloc] initWithArray:newData];
                        else
                        {
                            for( rowIdx = 0; rowIdx < totalRows; rowIdx++ )
                            {
                                workingSpace = [[NSMutableString alloc] initWithString:[part6 objectAtIndex:rowIdx]];
                                [workingSpace appendFormat:@"\t%@", [newData objectAtIndex:rowIdx]];
                                [part6 replaceObjectAtIndex:rowIdx withObject:workingSpace];
                            }
                        }
                    }
                    testName = [[NSString alloc] initWithFormat:@"%@_Part6.%@", fileName, extension];
                    for( rowIdx = 0; rowIdx < totalRows; rowIdx++)
                    {
                        if( rowIdx == 0 ) outputData = [[NSMutableString alloc] initWithString:[part6 objectAtIndex:rowIdx]];
                        else [outputData appendFormat:@"\n%@", [part6 objectAtIndex:rowIdx]];
                    }
                    [outputData writeToFile:[[NSString alloc] initWithString:testName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    break;
                default: break;
            }
        }
    }
}

- (NSArray *) storeData: (NSInteger) tableIndex isLeadingTable: (bool) isFirst
{
    /*=================================================================================================*
     *                                                                                                 *
     *                                         storeData                                               *
     *                                         =========                                               *
     *                                                                                                 *
     *  This method will create an array, in sequence, that represents a one of the displayed tables.  *
     *    These will then need to be collated to create a single file for each principal part.         *
     *                                                                                                 *
     *  tableIndex is the integer (0 to 17) that identifies the specific table                         *
     *  isFirst is true if this is the first table in a principal part (which means that it will       *
     *  include the side headings                                                                      *
     *                                                                                                 *
     *=================================================================================================*/
    NSInteger idx, noOfRows;
    NSString *var1, *var2, *var3, *singleRow;
    NSMutableArray *col1, *col2, *newTable;
    
    col1 = [allColumn1 objectAtIndex:tableIndex];
    col2 = [allColumn2 objectAtIndex:tableIndex];
    noOfRows = [titlesCol count];
    newTable = [[NSMutableArray alloc] init];
    if( isFirst)
    {
        for( idx = 0; idx < noOfRows; idx++)
        {
            var1 = [[NSString alloc] initWithString:[titlesCol objectAtIndex:idx]];
            if( [[col1 objectAtIndex:idx] length] == 0) var2 = @"";
            else var2 = [[NSString alloc] initWithString:[[col1 objectAtIndex:idx] string]];
            if( [[col2 objectAtIndex:idx] length] == 0) var3 = @"";
            else var3 = [[NSString alloc] initWithString:[[col2 objectAtIndex:idx] string]];
            singleRow = [[NSString alloc] initWithFormat:@"%@\t%@\t%@", var1, var2, var3];
            [newTable addObject:singleRow];
        }
    }
    else
    {
        for( idx = 0; idx < noOfRows; idx++)
        {
            if( [[col1 objectAtIndex:idx] length] == 0) var1 = @"";
            else var1 = [[NSString alloc] initWithString:[[col1 objectAtIndex:idx] string]];
            if( [[col2 objectAtIndex:idx] length] == 0) var2 = @"";
            else var2 = [[NSString alloc] initWithString:[[col2 objectAtIndex:idx] string]];
            singleRow = [[NSString alloc] initWithFormat:@"%@\t%@", var1, var2];
            [newTable addObject:singleRow];
        }
    }
    return [newTable copy];
}

- (void)doubleClick:(id)object
{
    NSInteger tagVal, rowNo, colVal;
    NSString *targetWord;
    NSArray *parseCol, *wordCol;
    NSTableView *sendingTable;

    sendingTable = (NSTableView *) object;
    rowNo = [sendingTable clickedRow];
    colVal = [sendingTable clickedColumn];
    tagVal = [sendingTable tag];
    // Get the list of references
    if( colVal == 1 )
    {
        parseCol = [[NSArray alloc] initWithArray:[allParse1 objectAtIndex:tagVal]];
        wordCol = [[NSArray alloc] initWithArray:[allCol1Master objectAtIndex:tagVal]];
    }
    else
    {
        parseCol = [[NSArray alloc] initWithArray:[allParse2 objectAtIndex:tagVal]];
        wordCol = [[NSArray alloc] initWithArray:[allColumn2 objectAtIndex:tagVal]];
    }
    targetWord = [wordCol objectAtIndex:rowNo];
    if( [targetWord length] > 0)
    {
        targetWord = [[NSString alloc] initWithString:[[wordCol objectAtIndex:rowNo] string]];
        refForm = [[frmReferences alloc] initWithWindowNibName:@"frmReferences"];
        [refForm displayReferences:[parseCol objectAtIndex:rowNo] forTheWordForm:targetWord usingBookList:listOfBooks withProcessesIn:detailsProcessing];
        [refForm showWindow:self];
        [refForm setParentController:self];
    }
}

- (IBAction)doSingularClick:(id)sender
{
    [self processButtonSelect:1];
}

- (IBAction)doPluralClick:(id)sender
{
    [self processButtonSelect:2];
}

- (void) processButtonSelect: (NSInteger) buttonCode
{
    NSInteger mainTabIndex, subTabIndex, tableNo = 0, rowNo;
    NSString *targetWord;
    NSMutableArray *currentColumn, *currentParse;
    NSTabView *currentSubTabView;
    NSTableView *currentTable;
    
    mainTabIndex = [mainTabView indexOfTabViewItem:[mainTabView selectedTabViewItem]];
    switch (mainTabIndex)
    {
        case 0: currentSubTabView = subTabView1; break;
        case 1: currentSubTabView = subTabView2; break;
        case 2: currentSubTabView = subTabView3; break;
        case 3: currentSubTabView = subTabView4; break;
        case 4: currentSubTabView = subTabView5; break;
        case 5: currentSubTabView = subTabView6; break;
        default: break;
    }
    subTabIndex = [currentSubTabView indexOfTabViewItem:[currentSubTabView selectedTabViewItem]];
    switch (mainTabIndex)
    {
        case 0:
            switch (subTabIndex)
            {
                case 0: currentTable = tvPresentActive; break;
                case 1: currentTable = tvImperfectActive; break;
                case 2: currentTable = tvPresentMiddle; break;
                case 3: currentTable = tvImperfectMiddle; break;
                case 4: currentTable = tvPresentPassive; break;
                case 5: currentTable = tvImperfectPassive; break;
                default: break;
            }
            tableNo = subTabIndex;
            break;
        case 1:
            switch (subTabIndex)
            {
                case 0: currentTable = tvFutureActive; break;
                case 1: currentTable = tvFutureMiddle; break;
                default: break;
            }
            tableNo = 6 + subTabIndex;
            break;
        case 2:
            switch (subTabIndex)
            {
                case 0: currentTable = tvAoristActive; break;
                case 1: currentTable = tvAoristMiddle; break;

                default: break;
            }
            tableNo = 8 + subTabIndex;
            break;
        case 3:
            switch (subTabIndex)
            {
                case 0: currentTable = tvPerfectActive; break;
                case 1: currentTable = tvPluperfectActive; break;
                default: break;
            }
            tableNo = 10 + subTabIndex;
            break;
        case 4:
            switch (subTabIndex)
            {
                case 0: currentTable = tvPerfectMiddle; break;
                case 1: currentTable = tvPluperfectMiddle; break;
                case 2: currentTable = tvPerfectPassive; break;
                case 3: currentTable = tvPluperfectPassive; break;
                default: break;
            }
            tableNo = 12 + subTabIndex;
            break;
        case 5:
            switch (subTabIndex)
            {
                case 0: currentTable = tvAoristPassive; break;
                case 1: currentTable = tvFuturePassive; break;
                default: break;
            }
            tableNo = 16 + subTabIndex;
            break;
        default: break;
    }
    // Get the list of references
    if( buttonCode == 1)
    {
        currentColumn = [[NSMutableArray alloc] initWithArray:[allColumn1 objectAtIndex:tableNo]];
        currentParse = [[NSMutableArray alloc] initWithArray:[allParse1 objectAtIndex:tableNo]];
    }
    else
    {
        currentColumn = [[NSMutableArray alloc] initWithArray:[allColumn2 objectAtIndex:tableNo]];
        currentParse = [[NSMutableArray alloc] initWithArray:[allParse2 objectAtIndex:tableNo]];
    }
    rowNo = [currentTable selectedRow];
    if( rowNo >= 0)
    {
        targetWord = [currentColumn objectAtIndex:rowNo];
        if( [targetWord length] > 0)
        {
            targetWord = [[NSString alloc] initWithString:[[currentColumn objectAtIndex:rowNo] string]];
            refForm = [[frmReferences alloc] initWithWindowNibName:@"frmReferences"];
            [refForm displayReferences:[currentParse objectAtIndex:rowNo] forTheWordForm:[[currentColumn objectAtIndex:rowNo] string] usingBookList:listOfBooks withProcessesIn:detailsProcessing];
            [refForm showWindow:self];
            [refForm setParentController:self];
        }
    }
}

- (NSString *) returnedValue: (NSString *) keyName forRow: (NSUInteger) row andTableId: (NSInteger) tableId
{
    if( [keyName isEqualToString: @"labels"] )
    {
        return [titlesCol objectAtIndex: row];
    }
    else if( [keyName isEqualToString: @"singular"] )
    {
        return [[allColumn1 objectAtIndex:tableId] objectAtIndex: row];
    }
    else if( [keyName isEqualToString: @"plural"] )
    {
        return [[allColumn2 objectAtIndex:tableId] objectAtIndex: row];
    }
    return nil;
}

#pragma mark - Table View Data Source

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger tableCount;
    
    tableCount = self.titlesCol.count;
    return tableCount;
}

- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSInteger tagVal;
    
    tagVal = [tableView tag];
    return [self returnedValue: tableColumn.identifier forRow: row andTableId:tagVal];
}

- (IBAction) doClose:(id)sender
{
    [self close];
}

@end
