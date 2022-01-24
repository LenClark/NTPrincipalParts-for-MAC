//
//  AppDelegate.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

@synthesize mainWindow;

@synthesize mainLoop;
@synthesize progressForm;
@synthesize vKeyboard;
@synthesize tvWordList;
@synthesize wordListContents;
@synthesize masterWordList;
@synthesize masterDescWordList;
@synthesize masterAscWordList;
@synthesize tvSummary;
@synthesize summaryLabels;
@synthesize summaryData;
@synthesize SummaryWord;
@synthesize keyEntryworkspace;
@synthesize selectionCriteriaLabel;
@synthesize verbDetails;
@synthesize helpForm;
@synthesize aboutForm;

@synthesize noOfNTBooks;
@synthesize noOfLXXBooks;
@synthesize noOfStoredBooks;

NSArray *summaryHeadings;

/*=====================================================================================================*
 *                                                                                                     *
 *                                            bookNames                                                *
 *                                            =========                                                *
 *                                                                                                     *
 *  This list stores information that allows us to access the data for NT books.  Each book is         *
 *  referenced by a code supplied in the titles file.  The list allows us to covert this into a        *
 *  meaningful book name.                                                                              *
 *                                                                                                     *
 *  Key:   A simple sequence number (1 upwards)                                                        *
 *  Value: An instance of classBook                                                                    *
 *                                                                                                     *
 *=====================================================================================================*/
NSMutableDictionary *bookNames;

/*----------------------------------------------------------------------------------------------------*
 *  listOfRoots                                                                                       *
 *  -----------                                                                                       *
 *                                                                                                    *
 *  Identifies the classRoot instance for a specific root word.                                       *
 *                                                                                                    *
 *  key:   A specifc root word                                                                        *
 *  value: The class instance for that word                                                           *
 *----------------------------------------------------------------------------------------------------*/
@synthesize listOfRoots;

/*----------------------------------------------------------------------------------------------------*
 *  frequencyTable                                                                                    *
 *  --------------                                                                                    *
 *                                                                                                    *
 *  Effectively provides a list of words and their frequency of occurrence in the New Testament.  The *
 *  only sensible way of sring this information is a list but this creates a problem: for any given   *
 *  number of occurrences there is likely to be several words with the same frequency (especially at  *
 *  low frequencies).  So, for each number of occurrences (1, 2, and so on) we have a class instance  *
 *  that stores all words with that frequency.  This list provides access to these instances.         *
 *                                                                                                    *
 *  key:   The frequency of occurrence of words (i.e. an integer)                                     *
 *  value: The class instance of the list of words with that frequency                                *
 *----------------------------------------------------------------------------------------------------*/
@synthesize frequencyTable;
@synthesize isSortedOnDescending;
@synthesize isSortedOnAscending;

classProcessing *globalMethods;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSInteger idx;

    noOfNTBooks = 0;
    noOfLXXBooks = 0;
    noOfStoredBooks = 0;
    isSortedOnDescending = false;
    isSortedOnAscending = false;
    keyEntryworkspace = [[NSMutableString alloc] initWithString:@""];
    frequencyTable = [[NSMutableDictionary alloc] init];
    
    // Set up the progress reporting mechanism
    [mainWindow setIsVisible:NO];
    mainLoop = [NSRunLoop mainRunLoop];
    progressForm = [[frmProgress alloc] initWithWindowNibName:@"frmProgress"];
    [progressForm showWindow:self];

    /*-----------------------------------------------------------------------*
     *   Initialise global variables - mainly classes.                       *
     *-----------------------------------------------------------------------*/
    globalMethods = [[classProcessing alloc] init];
    bookNames = [[NSMutableDictionary alloc] init];
    listOfRoots = [[NSMutableDictionary alloc] init];
    summaryHeadings = [[NSMutableArray alloc] initWithObjects: @"1 Present/Imperfect", @"2 Future Active/Middle", @"3 Aorist Active/Middle",
                       @"4 Perfect/Pluperfect Active", @"5 Perfect/Pluperfect Middle", @"6 Aorist/Future Passive", @"No. of times used in the NT", nil];
    summaryLabels = [[NSMutableArray alloc] initWithCapacity:7];
    for( idx = 0; idx < 7; idx++) [summaryLabels insertObject:[summaryHeadings objectAtIndex:idx] atIndex:idx];
    summaryData = [[NSMutableArray alloc] initWithCapacity:7];

    /*-----------------------------------------------------------------------*
     *   Store book titles and associated details.                           *
     *-----------------------------------------------------------------------*/
    [self processBookTitles];

    /*-----------------------------------------------------------------------*
     *   Store the actual text.                                              *
     *-----------------------------------------------------------------------*/
    [self storeText];

    /*-----------------------------------------------------------------------*
     *  Create a keyboard as part of access to the listbox                   *
     *-----------------------------------------------------------------------*/
    [self setupKeyboard];

    [self populateListbox];
    [self initialiseFrequencyTable];
    [progressForm close];
    [mainWindow setIsVisible:YES];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void) processBookTitles
{
    /*----------------------------------------------------------------------------------------------*
     *                                                                                              *
     *                                     processBookTitles                                        *
     *                                     -----------------                                        *
     *                                                                                              *
     *  Gets the details of biblical books from file and stores the relevant information in the     *
     *  class: classBook.  This includes file names for the method that actually loads the text.    *
     *                                                                                              *
     *  It occurs in two halves: one for the NT and one for the LXX.                                *
     *                                                                                              *
     *----------------------------------------------------------------------------------------------*/

    int idx;
    NSString *fullFileName, *fileContent, *lineContent;
    NSArray *fileContents, *fileByLine;
    classBooks *currentBook;

    [progressForm incrementProgress:@"Reading in details about Biblical books"];
    [mainLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
    fullFileName = [[NSBundle mainBundle] pathForResource:@"NTTitles" ofType:@"txt"];
    fileContent = [NSString stringWithContentsOfFile:fullFileName encoding:NSUTF8StringEncoding error:nil];
    fileByLine = [[NSArray alloc] initWithArray:[fileContent componentsSeparatedByString:@"\n"]];
    noOfNTBooks = 0;
    for( lineContent in fileByLine)
    {
        fileContents = [[NSArray alloc] initWithArray:[lineContent componentsSeparatedByString:@"\t"]];
        if( [fileContents count] < 3 ) continue;
        noOfNTBooks++;
        noOfStoredBooks++;
        currentBook = [[classBooks alloc] init];
        [currentBook setBookName:[fileContents objectAtIndex:0]];
        [currentBook setShortName:[fileContents objectAtIndex:1]];
        [currentBook setFileName:[fileContents objectAtIndex:2]];
        [currentBook setActualBookNumber:noOfNTBooks];
        [bookNames setValue:currentBook forKey:[globalMethods integerString:noOfStoredBooks]];
    }
    fullFileName = [[NSBundle mainBundle] pathForResource:@"LXX_Titles" ofType:@"txt"];
    fileContent = [NSString stringWithContentsOfFile:fullFileName encoding:NSUTF8StringEncoding error:nil];
    fileByLine = [[NSArray alloc] initWithArray:[fileContent componentsSeparatedByString:@"\n"]];
    idx = 0;
    for( lineContent in fileByLine)
    {
        if( [lineContent length] == 0) continue;;
        if ( [lineContent characterAtIndex:0] != ';')
        {
            noOfLXXBooks++;
            noOfStoredBooks++;
            fileContents = [[NSArray alloc] initWithArray:[lineContent componentsSeparatedByString:@"\t"]];
            currentBook = [[classBooks alloc] init];
            [currentBook setBookName:[fileContents objectAtIndex:1]];
            [currentBook setShortName:[fileContents objectAtIndex:0]];
            [currentBook setFileName:[fileContents objectAtIndex:3]];
            currentBook.actualBookNumber = noOfLXXBooks;
            [bookNames setValue:currentBook forKey:[globalMethods integerString:noOfStoredBooks]];
        }
    }
}

- (void) storeText
{
    /*----------------------------------------------------------------------------------------------*
     *                                                                                              *
     *                                        storeText                                             *
     *                                        ---------                                             *
     *                                                                                              *
     *  Now to get the actual text.                                                                 *
     *                                                                                              *
     *----------------------------------------------------------------------------------------------*/

    bool isNT = true, isVerb = false, isCompare;
    NSInteger idx, chapterSeq, verseSeq, parseCode, principalPartCode = 0;
    NSString *fullFileName, *partialFileName, *textBuffer, *bookName, *chapterNo, *verseNo, *prevChapNo, *prevVerseNo,
             *associatedRoot, *wordInstance, *cleanedWord, *tAssociatedRoot, *tWordInstance, *tCleanedWord, *lineContent, *singleField, *singleChar;
    NSArray *fileByLine, *fileContents;
    NSArray *grammarBreakdown;
    classBooks *currentBook;
    classChapter *currentChapter;
    classVerse *currentVerse;
    classRoot *newRoot;

    for (idx = 1; idx <= noOfStoredBooks; idx++)
    {
        if( idx > noOfNTBooks)
        {
            isNT = false;
        }
        currentBook = [bookNames objectForKey:[globalMethods integerString:idx]];
        if (currentBook != nil)
        {
            bookName = [currentBook bookName];
            [progressForm incrementProgress:bookName];
            [mainLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
            partialFileName = [[NSString alloc] initWithString:[currentBook fileName]];
            partialFileName = [[NSString alloc] initWithString:[partialFileName substringToIndex:[partialFileName length] - 4]];
            fullFileName = [[NSBundle mainBundle] pathForResource:partialFileName ofType:@"txt"];
            textBuffer = [NSString stringWithContentsOfFile:fullFileName encoding:NSUTF8StringEncoding error:nil];
            fileByLine = [[NSArray alloc] initWithArray:[textBuffer componentsSeparatedByString:@"\n"]];
            prevChapNo = @"?";
            chapterSeq = 0;
            prevVerseNo = @"?";
            verseSeq = 0;
            for( lineContent in fileByLine)
            {
                fileContents = [[NSArray alloc] initWithArray:[lineContent componentsSeparatedByString:@"\t"]];
                if( [fileContents count] >= 9 )
                {
                    chapterNo = [fileContents objectAtIndex:0];
                    if ( [chapterNo compare:prevChapNo] != NSOrderedSame)
                    {
                        chapterSeq++;
                        prevChapNo = [[NSString alloc] initWithString: chapterNo];
                        prevVerseNo = @"?";
                        verseSeq = 0;
                        currentChapter = [currentBook addChapter:chapterNo ofSequenceNo:chapterSeq];
                    }
                    verseNo = [fileContents objectAtIndex: 1];
                    if ( [verseNo compare:prevVerseNo] != NSOrderedSame )
                    {
                        verseSeq++;
                        prevVerseNo = [[NSString alloc] initWithString: verseNo];
                        currentVerse = [currentChapter addVerse:verseNo inSequence:verseSeq];
                    }
                    if( isNT)
                    {
                        [currentVerse addWord:[fileContents objectAtIndex:5] withLeadingChars:[fileContents objectAtIndex:13] followingChars:[fileContents objectAtIndex:14] andPunctuation:[fileContents objectAtIndex:15]];
                    }
                    else
                    {
                        [currentVerse addWord:[fileContents objectAtIndex:5] withLeadingChars:[fileContents objectAtIndex:14] followingChars:[fileContents objectAtIndex:15] andPunctuation:[fileContents objectAtIndex:16]];
                    }
                    isVerb = false;
                    if( isNT)
                    {
                        if ( [[fileContents objectAtIndex:2] compare: @"V-"] == NSOrderedSame) isVerb = true;
                            }
                    else
                    {
                        singleField = [[NSString alloc] initWithString:[fileContents objectAtIndex:2]];
                        singleChar = [[NSString alloc] initWithString:[singleField substringToIndex:1]];
                        isCompare = [singleChar compare:@"V"] == NSOrderedSame;
                        if( ( [singleField length] > 0) && isCompare) isVerb = true;
                    }
                    if( isVerb )
                    {
                        /*---------------------------------------------------------------------------------------*
                         *  Key to parameters:                                                                   *
                         *  -------------                                                                        *
                         *                                                                                       *
                         *  1   The book number/code                                                             *
                         *  2   simple chapter number (in string form) - allows out of sequence                  *
                         *  3   simple verse number (in string form) - dito                                      *
                         *  4   Full parse code (as normal)                                                      *
                         *  5   Word as appears in text (with punctuation already removed)                       *
                         *  6   Same word form but with accents, etc removed (but not breathings)                *
                         *  7   Root form of word                                                                *
                         *                                                                                       *
                         *  bookList:  The list containing the class instance in which the word occurs           *
                         *---------------------------------------------------------------------------------------*/


                          /*---------------------------------------------------------------------------------------*
                         *  parseCode:                                                                           *
                         *  ---------                                                                            *
                         *     We think of a word (e.g.λύω) as a single word in all its forms (e.g λύω, λύεις,   *
                         *       λύει).  We shall call the base word (actually, the lexeme), the "root" and the  *
                         *       seperate grammatical variations as "forms".                                     *
                         *                                                                                       *
                         *     The parseCode provides a numeric value that distinguishes each form from one      *
                         *       another                                                                         *
                         *                                                                                       *
                         *---------------------------------------------------------------------------------------*/
                        associatedRoot = [fileContents objectAtIndex:8];
                        tAssociatedRoot = [fileContents objectAtIndex:12];
                        if( isNT) parseCode = [globalMethods getNTParseInfo:[fileContents objectAtIndex:3]];
                        else parseCode = [globalMethods getLXXParseInfo:[fileContents objectAtIndex:3]];
                        wordInstance = [fileContents objectAtIndex:5];
                        tWordInstance = [fileContents objectAtIndex:9];
                        cleanedWord = [globalMethods cleanWord:wordInstance];
                        tCleanedWord = [globalMethods cleanTransliteratedWord:tWordInstance];
                        principalPartCode = [globalMethods principalPartCode];
                        grammarBreakdown = [globalMethods grammarBreakdown];
                        newRoot = [listOfRoots objectForKey:tAssociatedRoot];
                        if( newRoot == nil )
                        {
                            if( ! isNT ) continue;
                            newRoot = [[classRoot alloc] init];
                            [listOfRoots setObject:newRoot forKey:tAssociatedRoot];
                        }
                        [newRoot addRootInformation:isNT
                                       ofWordAsUsed:wordInstance
                              transliteratedVersion:tWordInstance
                                            cleaned:cleanedWord
                          transliteratedCleanedForm:tCleanedWord
                                 wordWithoutAccents:[fileContents objectAtIndex:6]
                              transliteredNoAccents:[fileContents objectAtIndex:10]
                                      withParseCode:parseCode
                               andPrincipalPartCode:principalPartCode
                                           bookName:bookName
                                   chapterReference:chapterNo
                                     verseReference:verseNo
                                           bookCode:idx + 1
                                    chapterSequence:chapterSeq
                                      verseSequence:verseSeq
                                      breakdownCode:grammarBreakdown
                                         processing:globalMethods];
                        [newRoot setRootWord:associatedRoot];
                    }
                }
            }
        }
    }
}

- (void) setupKeyboard
{
    NSUInteger idx, noOfKeys, keyHeight = 28, keyWidth = 28, keyBigWidth = 48, keyTop = 20, keyLeft = 10, keyGap = 4, keyRows = 3, keyCols = 10, actualHeight, gbHeight;
    NSButton *currentButton;
    NSArray *keyFaces = @[ @"α", @"β", @"γ", @"δ", @"ε", @"ζ", @"η", @"θ", @"ι", @"BkSp",
                           @"κ", @"λ", @"μ", @"ν", @"ξ", @"ο", @"π", @"ρ", @"σ", @"Clear", @"ς", @"τ", @"υ", @"φ", @"χ", @"ψ", @"ω"];
    NSArray *gkKeyHints = @[ @"alpha", @"beta", @"gamma", @"delta", @"epsilon", @"zeta", @"eta", @"theta", @"iota", @"Backspace",
                             @"kappa", @"lambda", @"mu", @"nu", @"xi", @"omicron", @"pi", @"rho", @"sigma", @"Clear",
                             @"final sigma", @"tau", @"upsilon", @"phi", @"chi", @"psi", @"omega"];

    [progressForm incrementProgress:@"Setting up the virtual keyboard"];
    [mainLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
    noOfKeys = [keyFaces count];
    keyRows = 0;
    keyCols = 0;
    gbHeight = [vKeyboard frame].size.height;
    for( idx = 0; idx < noOfKeys; idx++ )
    {
        switch (idx)
        {
            case 10:
            case 20:
                keyRows++;
                keyCols = 0;
                keyBigWidth = keyWidth;
                break;
            case 9:
            case 19:
                keyBigWidth = 56;
                break;
            default:
                keyBigWidth = keyWidth;
                break;
        }
        actualHeight = gbHeight - ( keyTop + (keyHeight + keyGap ) * ( keyRows + 1 ) );
        currentButton = [[NSButton alloc] initWithFrame:NSMakeRect(keyLeft + keyCols * (keyWidth + keyGap ), actualHeight - keyRows * (keyGap), keyBigWidth, keyHeight)];
        [currentButton setTag:idx];
        [currentButton setTitle:keyFaces[idx]];
        [currentButton setFont:[NSFont fontWithName:@"Times New Roman" size:16]];
        [currentButton setToolTip:gkKeyHints[idx]];
        [currentButton setAction:@selector(keyButton_Click:)];
        [[vKeyboard contentView] addSubview:currentButton];
        keyCols++;
    }
}

-(void) keyButton_Click: (id) sender
{
    NSInteger tagValue;
    
    tagValue = [sender tag];
    switch (tagValue)
    {
        case 9:
            [self removeLastChar];
            break;
        case 19:
            [self clearConstraints];
            break;
        default:
            [self processAddedChar:[sender title]];
            break;
    }
}

-(void) removeLastChar
{
    /*================================================================================*
     *                                                                                *
     *                                removeLastChar                                  *
     *                                ==============                                  *
     *                                                                                *
     *  Purpose:                                                                      *
     *  =======                                                                       *
     *                                                                                *
     *  a) Remove the last character added to the reported text entry string          *
     *       (selectionCriteriaLabel)                                                 *
     *  b) Reload entries into the "listbox" that match the selection criteria        *
     *                                                                                *
     *================================================================================*/
    
    NSInteger removalPstn, idx, noOfWords;
    NSString *sampledWord;
    NSMutableArray *wordListTemp;
    
    removalPstn = [keyEntryworkspace length];
    if( removalPstn == 0 ) return;
    if( removalPstn == 1 )
    {
        [self clearConstraints];
    }
    else
    {
        wordListTemp = [[NSMutableArray alloc] init];
        removalPstn--;
        keyEntryworkspace = [[NSMutableString alloc] initWithString:[keyEntryworkspace substringWithRange:NSMakeRange(0, removalPstn )]];
        noOfWords = [masterWordList count];
        [wordListContents removeAllObjects];
        for( idx = 0; idx < noOfWords; idx++)
        {
            sampledWord = [[NSString alloc] initWithString:[masterWordList objectAtIndex:idx]];
            if( [sampledWord length] < removalPstn) continue;
            if( [keyEntryworkspace compare:[globalMethods stripAll:[sampledWord substringToIndex:removalPstn]]] == NSOrderedSame) [wordListContents addObject:sampledWord];
        }
        [tvWordList reloadData];
        [selectionCriteriaLabel setStringValue:keyEntryworkspace];
    }
}

-(void) clearConstraints
{
    keyEntryworkspace = [[NSMutableString alloc] initWithString:@""];
    [wordListContents removeAllObjects];
    [wordListContents addObjectsFromArray:masterWordList];
    [tvWordList reloadData];
    [selectionCriteriaLabel setStringValue:@"None"];
}

-(void) processAddedChar: (NSString *) newChar
{
    /*================================================================================*
     *                                                                                *
     *                                processAddedChar                                *
     *                                ================                                *
     *                                                                                *
     *  Purpose:                                                                      *
     *  =======                                                                       *
     *                                                                                *
     *  a) Add a character to the reported text entry string (selectionCriteriaLabel) *
     *  b) Remove entries from the "listbox" that do not match the selection criteria *
     *                                                                                *
     *  Step b) in more detail:                                                       *
     *     i)   Find the length of the new entered text;                              *
     *     ii)  Step through the wordListContents that form the current list;         *
     *     iii) If the currently inspected word in the list is less than the length   *
     *          found in i), ignore it.                                               *
     *     iv)  Otherwise, truncate the inspected word to the same length             *
     *     v)   If the truncated word matches the text entered by the virtual         *
     *          keyboard, add the original word from the list *in the same order* to  *
     *          the temporary array of words                                          *
     *     vi)  when finished, transfer the reduced list to wordListContents and      *
     *          redo the list in the "listbox".                                       *
     *                                                                                *
     *================================================================================*/
    
    NSInteger idx, noOfWords, addPstn;
    NSString *incresedEntry, *sampledWord;
    NSMutableArray *wordListTemp;
    
    wordListTemp = [[NSMutableArray alloc] init];
    addPstn = [keyEntryworkspace length];
    incresedEntry = [[NSString alloc] initWithFormat:@"%@%@", keyEntryworkspace, newChar];
    addPstn++;
    noOfWords = [wordListContents count];
    for( idx = noOfWords - 1; idx >= 0; idx--)
    {
        sampledWord = [[NSString alloc] initWithString:[wordListContents objectAtIndex:idx]];
        if( [sampledWord length] < addPstn)
        {
            [wordListContents removeObjectAtIndex:idx];
            continue;
        }
        if( [incresedEntry compare:[globalMethods stripAll:[sampledWord substringToIndex:addPstn]]] != NSOrderedSame)
        {
            [wordListContents removeObjectAtIndex:idx];
        }
    }
    [tvWordList reloadData];
    keyEntryworkspace = [incresedEntry mutableCopy];
    [selectionCriteriaLabel setStringValue:keyEntryworkspace];
}

- (void) populateListbox
{
    NSInteger idx, noOfItems;
    NSString *rootWord, *tRootWord, *strippedWord, *testWord;
    NSMutableArray *altWordList, *candidateMaster;
    NSMutableDictionary *rootLookup;
    classRoot *currentRootInstance;
    
    [progressForm incrementProgress:@"Populating the main list of words"];
    [mainLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
    rootLookup = [[NSMutableDictionary alloc] init];
    altWordList = [[NSMutableArray alloc] init];
    candidateMaster = [[NSMutableArray alloc] init];
    for( tRootWord in listOfRoots)
    {
        currentRootInstance = [listOfRoots objectForKey:tRootWord];
        rootWord = [currentRootInstance rootWord];
        strippedWord = [[NSString alloc] initWithString:[globalMethods stripAll:rootWord]];
        testWord = [rootLookup objectForKey:rootWord];
        if( testWord == nil)
        {
            [rootLookup setObject:rootWord forKey:strippedWord];
            [altWordList addObject:strippedWord];
        }
    }
    [altWordList sortUsingSelector:@selector(caseInsensitiveCompare:)];
    noOfItems = [altWordList count];
    for( idx = 0; idx < noOfItems; idx++)
    {
        testWord = [[NSString alloc] initWithString:[altWordList objectAtIndex:idx]];
        [candidateMaster addObject:[rootLookup objectForKey:testWord]];
    }
    wordListContents = [[NSMutableArray alloc] initWithArray:candidateMaster];
    masterWordList = [[NSArray alloc] initWithArray:wordListContents];
    [tvWordList reloadData];
    [tvWordList selectRowIndexes:[[NSIndexSet alloc] initWithIndex:0] byExtendingSelection:YES];
}

- (void) alphabeticListbox
{
    wordListContents = [[NSMutableArray alloc] initWithArray:masterWordList];
    [tvWordList reloadData];
    [tvWordList selectRowIndexes:[[NSIndexSet alloc] initWithIndex:0] byExtendingSelection:YES];
}

- (void) descendingListbox
{
    NSInteger idx, jdx, noOfWords, noOfEntries;
    NSString *rootWord, *tRootWord, *freqEntry, *adjustedFreq;
    NSMutableArray *candidateMaster, *keyMaster;
    NSMutableDictionary *numberList;
    classRoot *currentRootInstance;
    classFrequency *frequencyInstance;

    if( isSortedOnDescending )
    {
        wordListContents = [[NSMutableArray alloc] initWithArray:masterDescWordList];
    }
    else
    {
        candidateMaster = [[NSMutableArray alloc] init];
        numberList = [[NSMutableDictionary alloc] init];
        for( freqEntry in frequencyTable)
        {
            // Make sure we can get the original frequency table key from the sortable zero-initialised value
            [numberList setValue:freqEntry forKey:[self addLeadingZeros:freqEntry withFinalLength:6]];
        }
        // Create an array of the zero-initialised key
        keyMaster = [[NSMutableArray alloc] initWithArray:[numberList allKeys]];
        // Now sort the zero-initialised keys
        [keyMaster sortUsingSelector:@selector(caseInsensitiveCompare:)];
        noOfEntries = [keyMaster count];
        for( jdx = noOfEntries - 1; jdx >= 0; jdx-- )
        {
            // Now create the "master array" of words
            adjustedFreq = [keyMaster objectAtIndex:jdx];
            freqEntry = [[NSString alloc] initWithString:[numberList objectForKey:adjustedFreq]];
            frequencyInstance = [frequencyTable objectForKey:freqEntry];
            noOfWords = [frequencyInstance listCount];
            for( idx = 0; idx < noOfWords; idx++)
            {
                tRootWord = [frequencyInstance getRootNameByIndex:idx withMethodClass:globalMethods];
                currentRootInstance = [listOfRoots objectForKey:tRootWord];
                rootWord = [currentRootInstance rootWord];
                [candidateMaster addObject:rootWord];
            }
        }
        wordListContents = [[NSMutableArray alloc] initWithArray:candidateMaster];
        masterDescWordList = [[NSArray alloc] initWithArray:wordListContents];
        isSortedOnDescending = true;
    }
    [tvWordList reloadData];
    [tvWordList selectRowIndexes:[[NSIndexSet alloc] initWithIndex:0] byExtendingSelection:YES];
}

- (void) ascendingListbox
{
    NSInteger idx, noOfWords;
    NSString *rootWord, *tRootWord, *freqEntry, *adjustedFreq;
    NSMutableArray *candidateMaster, *keyMaster;
    NSMutableDictionary *numberList;
    classRoot *currentRootInstance;
    classFrequency *frequencyInstance;

    if( isSortedOnAscending )
    {
        wordListContents = [[NSMutableArray alloc] initWithArray:masterAscWordList];
    }
    else
    {
        candidateMaster = [[NSMutableArray alloc] init];
        numberList = [[NSMutableDictionary alloc] init];
        for( freqEntry in frequencyTable)
        {
            // Make sure we can get the original frequency table key from the sortable zero-initialised value
            [numberList setValue:freqEntry forKey:[self addLeadingZeros:freqEntry withFinalLength:6]];
        }
        // Create an array of the zero-initialised key
        keyMaster = [[NSMutableArray alloc] initWithArray:[numberList allKeys]];
        // Now sort the zero-initialised keys
        [keyMaster sortUsingSelector:@selector(caseInsensitiveCompare:)];
        for( adjustedFreq in keyMaster )
        {
            // Now create the "master array" of words
            freqEntry = [[NSString alloc] initWithString:[numberList objectForKey:adjustedFreq]];
            frequencyInstance = [frequencyTable objectForKey:freqEntry];
            noOfWords = [frequencyInstance listCount];
            for( idx = 0; idx < noOfWords; idx++)
            {
                tRootWord = [frequencyInstance getRootNameByIndex:idx withMethodClass:globalMethods];
                currentRootInstance = [listOfRoots objectForKey:tRootWord];
                rootWord = [currentRootInstance rootWord];
                [candidateMaster addObject:rootWord];
            }
        }
        wordListContents = [[NSMutableArray alloc] initWithArray:candidateMaster];
        masterAscWordList = [[NSArray alloc] initWithArray:wordListContents];
        isSortedOnAscending = true;
    }
    [tvWordList reloadData];
    [tvWordList selectRowIndexes:[[NSIndexSet alloc] initWithIndex:0] byExtendingSelection:YES];
}

- (IBAction)doListChange:(NSButton *)sender
{
    NSInteger tagVal;
    NSButton *selectedButton;
    
    selectedButton = sender;
    if( [selectedButton state] == NSControlStateValueOn )
    {
        tagVal = [selectedButton tag];
        switch (tagVal)
        {
            case 0: [self alphabeticListbox]; break;
            case 1: [self descendingListbox]; break;
            case 2: [self ascendingListbox]; break;
            default: break;
        }
    }
}

- (NSString *) addLeadingZeros: (NSString *) baseNo withFinalLength: (NSInteger) noLength
{
    NSInteger idx, baseLength;
    NSString *workArea;
    
    baseLength = [baseNo length];
    if( baseLength >= noLength ) return baseNo;
    workArea = [[NSString alloc] initWithString:baseNo];
    for( idx = baseLength + 1; idx < noLength; idx++) workArea = [[NSString alloc] initWithFormat:@"0%@", workArea];
    return workArea;
}

- (void) initialiseFrequencyTable
{
    NSInteger rootCount;
    NSString *tRootWord;
    classRoot *rootClass;
    classFrequency *freqInstance;

    [progressForm incrementProgress:@"Populating frequency stats"];
    [mainLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
    for (tRootWord in listOfRoots)
    {
        rootClass = [listOfRoots objectForKey:tRootWord];
        rootCount = [rootClass frequencyInNT];
        freqInstance = [frequencyTable objectForKey:[globalMethods integerString:rootCount]];
        if (freqInstance == nil)
        {
            freqInstance = [[classFrequency alloc] init];
            [frequencyTable setObject:freqInstance forKey:[globalMethods integerString:rootCount]];
        }
        [freqInstance addRootEntry:tRootWord withMethodClass:globalMethods];
    }
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger idx, noOfRows, summarySize, rowNum;
    NSString *targetWord, *translitTargetWord;
    NSTableView *tableName;
    classRoot *currentRoot;
    
    tableName = [notification object];
    if( tableName == tvWordList )
    {
        // First of all, get the selected word
        rowNum = [tvWordList selectedRow];
        if ( rowNum < 0 )
        {
            [tvWordList selectRowIndexes:[[NSIndexSet alloc] initWithIndex:0] byExtendingSelection:NO];
            return;
        }
        targetWord = [[NSString alloc] initWithString:[wordListContents objectAtIndex:rowNum]];
        translitTargetWord = [globalMethods transliterateGreekWord:targetWord];
        // Now prepare the changing part of the summary table
        summarySize = [summaryHeadings count];
        currentRoot = [listOfRoots objectForKey:translitTargetWord];
        [summaryData removeAllObjects];
        for (idx = 0; idx < 7; idx++) [summaryData addObject:@""];
        noOfRows = 0;
        if (currentRoot != nil)
        {
            [currentRoot orderByParseCode];
            [SummaryWord setStringValue:targetWord];
            summaryData = [[NSMutableArray alloc] initWithArray:[currentRoot bestParse]];
        }
        [summaryData addObject:[globalMethods integerString:[currentRoot frequencyInNT]]];
        [tvSummary reloadData];
    }
}

- (IBAction)doAbout:(id)sender
{
    aboutForm = [[frmAbout alloc] initWithWindowNibName:@"frmAbout"];
    [aboutForm showWindow:self];
}

- (IBAction)doHelp:(id)sender
{
    helpForm = [[frmHelp alloc] initWithWindowNibName:@"frmHelp"];
    [helpForm showWindow:nil];
}

#pragma mark - Table View Data Source

-    (NSInteger) numberOfRowsInTableView: (NSTableView *)tableView
{
    if( tableView == tvWordList)
    {
        return self.wordListContents.count;
    }
    else
    {
        return self.summaryLabels.count;
    }
    return 0;
}

- (NSString *) returnedValue: (NSString *) keyName forRow: (NSUInteger) row andTableId: (NSInteger) tableId
{
    switch (tableId)
    {
        case 1:
            if( [keyName isEqualToString: @"word_list"] )
            {
                return [wordListContents objectAtIndex: row];
            }
            break;
        case 2:
            if( [keyName isEqualToString: @"titles"] )
            {
                return [summaryLabels objectAtIndex: row];
            }
            else if( [keyName isEqualToString: @"info"] )
            {
                return [summaryData objectAtIndex: row];
            }
            break;
        default:
            break;
    }
    return nil;
}

-    (id) tableView:(NSTableView *)tableView objectValueForTableColumn: (NSTableColumn *)tableColumn
                row:(NSInteger)row
{
    NSInteger tagVal;
    
    tagVal = [tableView tag];
    return [self returnedValue: tableColumn.identifier forRow: row andTableId:tagVal];
}

- (IBAction) doViewDetails:(id)sender
{
    NSString *currentRoot, *translitRoot;
    classRoot *rootWord;

    currentRoot = [[NSString alloc] initWithString:[SummaryWord stringValue]];
    if( currentRoot == nil) return;
    if( [currentRoot length] == 0 ) return;
    translitRoot = [globalMethods transliterateGreekWord:currentRoot];
    rootWord = [listOfRoots objectForKey:translitRoot];
    verbDetails = [[frmVerbDetails alloc] initWithWindowNibName:@"frmVerbDetails"];
    [verbDetails initialiseDetails:rootWord withBookList:[bookNames copy] andProcessClass:globalMethods];
    [verbDetails showWindow:self];
}

- (IBAction) doClose:(id)sender
{
    [[NSApplication sharedApplication] terminate:nil];
}


@end
