//
//  frmReferences.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 20/01/2022.
//

#import "frmReferences.h"

@interface frmReferences ()

@end

@implementation frmReferences

@synthesize referenceWindow;
@synthesize referencedWordForm;
@synthesize parentController;
@synthesize listOfBooks;
@synthesize refProcs;
@synthesize idList;
@synthesize indexedBookName;
@synthesize indexedChapter;
@synthesize indexedFullRef;
@synthesize indexedVerse;
@synthesize column1;
@synthesize column2;
@synthesize column3;
@synthesize tvReferences;
@synthesize chapterDisplay;

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (void) awakeFromNib
{
    [tvReferences setTarget:self];
    [tvReferences setDoubleAction:@selector(doubleClick:)];
}

- (void) displayReferences: (NSDictionary *) referenceList forTheWordForm: (NSString *) wordForm usingBookList: (NSDictionary *) inListOfBooks withProcessesIn: (classProcessing *) inRefProcs
{
    /*===========================================================================================================*
     *                                                                                                           *
     *                                            displayReferences                                              *
     *                                            =================                                              *
     *                                                                                                           *
     *  The reference list provides the basic reference information (book name, chapter and verse) but in a more *
     *    or less random order.  The main task of the display is to sort them and present them in an acceptable  *
     *    format.                                                                                                *
     *                                                                                                           *
     *  There are 86 books in total.  The most chapters of any book is 150 (or 151) and the most verses of any   *
     *    chapter is also 150.  So, the formula:                                                                 *
     *             book ref * 1000000 + chapter * 1000 + verse                                                   *
     *    will give us a unique key for each reference and will be in order.                                     *
     *                                                                                                           *
     *===========================================================================================================*/
    
    bool isBookChange, isChapterChange;
    NSInteger bookNo, chapterSeq, verseSeq, uniqueRef;
    NSString *parseString, *bookName, *chapter, *verse, *prevBookName, *prevChapter, *prevVerse, *uniqueRefString, *partialRef, *windowTitle;
    classReference *referenceClass;
    
    referencedWordForm = wordForm;
    windowTitle = [[NSString alloc] initWithFormat:@"References for the word form: %@", wordForm];
    [[self window] setTitle:windowTitle];
    listOfBooks = inListOfBooks;
    refProcs = inRefProcs;
    if( idList == nil) idList = [[NSMutableArray alloc] init];
    if( indexedBookName == nil) indexedBookName = [[NSMutableDictionary alloc] init];
    if( indexedChapter == nil) indexedChapter = [[NSMutableDictionary alloc] init];
    if( indexedFullRef == nil) indexedFullRef = [[NSMutableDictionary alloc] init];
    if( indexedVerse == nil) indexedVerse = [[NSMutableDictionary alloc] init];
    if( column1 == nil) column1 = [[NSMutableArray alloc] init];
    if( column2 == nil) column2 = [[NSMutableArray alloc] init];
    if( column3 == nil) column3 = [[NSMutableArray alloc] init];

    for( parseString in referenceList)
    {
        referenceClass = [referenceList objectForKey:parseString];
        bookNo = [referenceClass bookNo];
        chapterSeq = [referenceClass chapterSeq];
        verseSeq = [referenceClass verseSeq];
        bookName = [[NSString alloc] initWithString:[referenceClass bookName]];
        chapter = [[NSString alloc] initWithString:[referenceClass chapter]];
        verse = [[NSString alloc] initWithString:[referenceClass verse]];
        uniqueRef = bookNo * 1000000 + chapterSeq * 1000 + verseSeq;
        if( uniqueRef < 10000000 ) uniqueRefString = [[NSString alloc] initWithFormat:@"0%li", uniqueRef];
        else uniqueRefString = [[NSString alloc] initWithFormat:@"%li", uniqueRef];
        [idList addObject:uniqueRefString];
        [indexedBookName setObject:bookName forKey:uniqueRefString];
        [indexedChapter setObject:chapter forKey:uniqueRefString];
        [indexedFullRef setObject:[[NSString alloc] initWithFormat:@"%@ %@:%@", bookName, chapter, verse] forKey:uniqueRefString];
        [indexedVerse setObject:verse forKey:uniqueRefString];
    }
    // Sort the key
    [idList sortUsingSelector:@selector(caseInsensitiveCompare:)];
    prevBookName = @"?";
    isBookChange = true;
    isChapterChange = true;
    for( uniqueRefString in idList)
    {
        bookName = [indexedBookName objectForKey:uniqueRefString];
        if( [bookName compare:prevBookName] != NSOrderedSame)
        {
            [column1 addObject:bookName];
            prevBookName = [[NSString alloc] initWithString:bookName];
            prevChapter = @"?";
            isBookChange = true;
        }
        else isBookChange = false; // [column1 addObject:@""];
        chapter = [indexedChapter objectForKey:uniqueRefString];
        if( [chapter compare:prevChapter] != NSOrderedSame )
        {
            [column2 addObject:chapter];
            prevChapter = [[NSString alloc] initWithString:chapter];
            prevVerse = @"?";
            isChapterChange = true;
            if( ! isBookChange ) [column1 addObject:@""];
        }
        else isChapterChange = false; // added chapter
        if( isChapterChange)
        {
            [column3 addObject:[indexedFullRef objectForKey:uniqueRefString]];
        }
        else
        {
            partialRef = [[NSString alloc] initWithString:[column3 lastObject]];
//            partialRef = [[NSString alloc] initWithString:[indexedFullRef objectForKey:uniqueRefString]];
            verse = [indexedVerse objectForKey:uniqueRefString];
            [column3 removeLastObject];
            [column3 addObject:[[NSString alloc] initWithFormat:@"%@, %@", partialRef, verse]];
        }
    }
    [tvReferences reloadData];
}

- (void)doubleClick:(id)object
{
    NSTableView *sendingTable;

    sendingTable = (NSTableView *) object;
    [self activateDisplay: [sendingTable clickedRow]];
}

- (IBAction)doDisplay:(id)sender
{
    [self activateDisplay: [tvReferences selectedRow]];
}

- (void) activateDisplay: (NSInteger) rowNumber
{
    NSInteger goBack;
    NSString *bookName;

    if( rowNumber < 0 ) return;
    goBack = rowNumber;
    bookName = [column1 objectAtIndex:goBack];
    while ([bookName length] == 0) {
        bookName = [column1 objectAtIndex: --goBack];
    }
    chapterDisplay = [[frmChapter alloc] initWithWindowNibName:@"frmChapter"];
    [chapterDisplay showWindow:self];
    [chapterDisplay processReference:[column3 objectAtIndex:rowNumber] forBook:bookName andChapter:[column2 objectAtIndex:rowNumber] including:listOfBooks procsLoc:refProcs];
    [chapterDisplay setParentController:self];
    [chapterDisplay setGrandparentController:parentController];
}

- (IBAction) doSaveAsCSV:(id)sender
{
    NSUInteger rowIdx, totalRows, saveRes;
    NSSavePanel *savePanel;
    NSString *startingDirectory, *fileName;
    NSMutableString *outputData;
    NSArray *allowedFileTypes;
    NSURL *resultingLoc, *startingLoc;
    NSError *error;

    allowedFileTypes = [[NSArray alloc] initWithObjects:@"csv", @"txt", @"doc", nil];
    startingDirectory = [[NSString alloc] initWithString:[@"~" stringByExpandingTildeInPath]];
    startingLoc = [[NSURL alloc] initFileURLWithPath:startingDirectory];
    savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:[[NSString alloc] initWithFormat:@"%@_References.csv", referencedWordForm]];
    [savePanel setAllowsOtherFileTypes:true];
    [savePanel setMessage:@"Select where you want to save the file, then click on \"Save\""];
    [savePanel setCanCreateDirectories:true];
    [savePanel setTitle:[[NSString alloc] initWithFormat:@"Save the list of references for %@ in CSV format", referencedWordForm]];
    [savePanel setDirectoryURL:startingLoc];
    saveRes = [savePanel runModal];
    if( saveRes == NSModalResponseOK )
    {
        resultingLoc = [savePanel URL];
        fileName = [[NSString alloc] initWithString:[resultingLoc path]];
        totalRows = [column3 count];
        for( rowIdx = 0; rowIdx < totalRows; rowIdx++)
        {
            if( rowIdx == 0 ) outputData = [[NSMutableString alloc] initWithFormat:@"%@\t%@\t%@", [column1 objectAtIndex:rowIdx], [column2 objectAtIndex:rowIdx], [column3 objectAtIndex:rowIdx]];
            else [outputData appendFormat:@"\n%@\t%@\t%@", [column1 objectAtIndex:rowIdx], [column2 objectAtIndex:rowIdx], [column3 objectAtIndex:rowIdx]];
        }
        [outputData writeToFile:[[NSString alloc] initWithString:fileName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
}

- (IBAction)doBackToBase:(id)sender
{
    [parentController close];
    [self close];
}

- (IBAction)doClose:(id)sender
{
    [self close];
}

- (NSString *) returnedValue: (NSString *) keyName forRow: (NSUInteger) row
{
    if( [keyName isEqualToString: @"book"] )
    {
        return [column1 objectAtIndex: row];
    }
    else if ( [keyName isEqualToString: @"chapter"] )
    {
        return [column2 objectAtIndex: row];
    }
    else if ( [keyName isEqualToString: @"reference"] )
    {
        return [column3 objectAtIndex: row];
    }
    else
    {
        return nil;
    }
}

#pragma mark - Table View Data Source

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.column1.count;
}

- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self returnedValue: tableColumn.identifier forRow: row];
}

@end
