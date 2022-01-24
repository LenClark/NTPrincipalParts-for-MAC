/*=========================================================================================================*
 *                                                                                                         *
 *                                              classRoot                                                  *
 *                                              =========                                                  *
 *                                                                                                         *
 *  This class holds all information relating to the root word.  In practice, we hold very little          *
 *    information specifically relating to the root.  Only:                                                *
 *                                                                                                         *
 *  rootWord            The word provided by the source data as root                                       *
 *  frequencyInNT       The number of times the entire word is used in the NT                              *
 *  frequencyInLXX      The number of times the entire word is used in the LXX                             *
 *  parsedDetails       A list of each specific form used for the root (see below)                         *
 *                                                                                                         *
 *  All other data is effectively passed through to one or other parseDetail instance.                     *
 *                                                                                                         *
 *  Date: 9 Jan 2022                                                                                       *
 *  Author: Len Clark                                                                                      *
 *                                                                                                         *
 *=========================================================================================================*/

#import "classRoot.h"

@implementation classRoot

@synthesize isParseOrdered;
@synthesize frequencyInNT;
@synthesize frequencyInOT;
@synthesize parseCount;
@synthesize rootWord;

/*---------------------------------------------------------------------------------------------------------*
 *                                                                                                         *
 *                                            parsedDetails                                                *
 *                                            -------------                                                *
 *                                                                                                         *
 *  I wish I had a better name for this!                                                                   *
 *                                                                                                         *
 *  A "parse detail" is a specific grammatical form of a verb (e.g. 1st singular present indicative active *
 *    or genitive plural feminine aorist active participle)  There may be variations in the specific form  *
 *    the detail takes but, grammatically, they are the same thing.                                        *
 *                                                                                                         *
 *  This is a list of all parsedDetail instances created for the given root, identified by parseCode       *
 *                                                                                                         *
 *  key:   the parseCode of the current word form                                                          *
 *  value: the parsedDetail instance for the keyed parseCode                                               *
 *                                                                                                         *
 *---------------------------------------------------------------------------------------------------------*/
@synthesize parsedDetails;

/*---------------------------------------------------------------------------------------------------------*
 *                                                                                                         *
 *                                              bestParse                                                  *
 *                                              ---------                                                  *
 *                                                                                                         *
 *  This is specifically for use by the summary table population.                                          *
 *                                                                                                         *
 *  It is indexed on the principla parts (Present/imperfect = 0, etc) and the values aare instance         *
 *    addresses for the relevant parse detail                                                              *
 *                                                                                                         *
 *---------------------------------------------------------------------------------------------------------*/
@synthesize bestParse;

@synthesize rootProcessing;

- (id) init
{
    self = [super init];
    parsedDetails = [[NSMutableDictionary alloc] init];
//    parseCodeDecode = [[NSMutableDictionary alloc] init];
    isParseOrdered = false;
    return self;
}

- (void) addRootInformation: (bool) isNT ofWordAsUsed: (NSString *) specificWord transliteratedVersion: (NSString *) tSpecificWord
                    cleaned: (NSString *) cleanedWord transliteratedCleanedForm: (NSString *) tCleanedWord
         wordWithoutAccents: (NSString *) noAccent transliteredNoAccents: (NSString *) tNoAccent
              withParseCode: (NSInteger) parseCode andPrincipalPartCode: (NSInteger) principalPartCode
                   bookName: (NSString *) bookName chapterReference: (NSString *) chapter verseReference: (NSString *) verse
                   bookCode: (NSInteger) bookNo chapterSequence: (NSInteger) chapterSeq verseSequence: (NSInteger) verseSeq
              breakdownCode: (NSArray *) inBreakdown
                 processing: (classProcessing *) gkMethod
{
    /*=========================================================================================================*
     *                                                                                                         *
     *                                            addRootInformation                                           *
     *                                            ==================                                           *
     *                                                                                                         *
     *  The actual root form is contained in rootWordList and rootWordIndex in the frmMain code.               *
     *                                                                                                         *
     *  Parameters:                                                                                            *
     *  ==========                                                                                             *
     *                                                                                                         *
     *  specificWord        The word as used in the text                                                       *
     *  parseCode           The parse code (processed)                                                         *
     *  principalPartCode   A code that identifies to which Principal Part this specific word belongs          *
     *  bookName            The name of the book                                                               *
     *  chapter             String value of chapter                                                            *
     *  verse               String value of verse                                                              *
     *  inBreakdown         A breakdown of the parse code, as follows:                                         *
     *                        item                 meaning                                                     *
     *                         0      person - 0 (none), 1, 2 or 3                                             *
     *                         1      singular or plural - 1 or 2                                              *
     *                         2      case - 1 - 5 (Nom., Voc., Acc., Gen., Dat.)                              *
     *                         3      gender - 1 = masc, 2 = neut, 3 = fem                                     *
     *                         4      tense - 1 = present                                                      *
     *                                        2 = imperfect                                                    *
     *                                        3 = aorist                                                       *
     *                                        4 = perfect                                                      *
     *                                        5 = pluperfect                                                   *
     *                                        6 = future                                                       *
     *                         5      Mood - 1 = indicative                                                    *
     *                                       2 = imperative                                                    *
     *                                       3 = subjunctive                                                   *
     *                                       4 = optative                                                      *
     *                                       5 = infinitive                                                    *
     *                                       6 = participle                                                    *
     *                         6      Voice - 1 - 3 (Active, Middle, Passive)                                  *
     *                                                                                                         *
     *=========================================================================================================*/

    /*---------------------------------------------------------------------------------------------------------*
     *                                                                                                         *
     *                                       newParseDetail                                                    *
     *                                       --------------                                                    *
     *                                                                                                         *
     *  Stores all the information about a specific grammatical element - e.g. 1st singular present indicative *
     *    active or masculine singular nominative aorist active participle.                                    *
     *                                                                                                         *
     *  It may hold information of multiple occurrences of the same grammatical element.                       *
     *                                                                                                         *
     *---------------------------------------------------------------------------------------------------------*/
    classParseDetail *newParseDetail;

    rootProcessing = gkMethod;
    if (isNT) frequencyInNT++;
    else frequencyInOT++;
    newParseDetail = [parsedDetails objectForKey:[gkMethod integerString: parseCode]];
    if (newParseDetail == nil)
    {
        newParseDetail = [[classParseDetail alloc] init];
        [parsedDetails setObject:newParseDetail forKey:[gkMethod integerString: parseCode]];
    }
    // So now we have either a newly created parseDetail or one that has already got some info
    [newParseDetail addParseDetail:specificWord
             transliteratedVersion:tSpecificWord
                           cleaned:cleanedWord
           transliteratedCleanForm: tCleanedWord
                    withoutAccents:noAccent
           transliteratedNoAccents:tNoAccent
                    havingPartCode:principalPartCode
                      andParseCode:parseCode
                      withBookName:bookName
                  chapterReference:chapter
                   verseRdeference:verse
                          bookCode:bookNo
                   chapterSequence:chapterSeq
                     verseSequence:verseSeq
                   supportingClass:gkMethod
                           andFlag:isNT];
    [newParseDetail setGrammarBreakdown:inBreakdown];
}

- (void) orderByParseCode
{
    /*==========================================================================================================*
     *                                                                                                          *
     *                                          orderByParseCode                                                *
     *                                          ================                                                *
     *                                                                                                          *
     *  The idea of this method is a one-time ordering of all the parse codes for a given root word.  The       *
     *    class-global boolean, isParseOrdered, ensures that we don't duplicate the process every time we call  *
     *    the method.  The ordered list, stored in parseCodeDecode, should remain across calls.                 *
     *                                                                                                          *
     *  The idea behind the ordering is that the best representative of each principal part is the form that    *
     *    functions within the principal part with the lowest parse code.  (Is this really the case?)           *
     *                                                                                                          *
     *  dictionaryKey is the NSString form of the parseCode.                                                    *
     *  parseCount is simply a sequential integer value                                                         *
     *                                                                                                          *
     *==========================================================================================================*/
    
    NSInteger idx, ndx, numberCount, parseCode, prevPCode, principalPart;
    NSString *dictionaryKey;
    NSMutableString *summaryEntry;
    NSArray *wordList;
    NSMutableArray *tempStore;
    classParseDetail *currentDetail;
    
    if (isParseOrdered) return;
    tempStore = [[NSMutableArray alloc] initWithCapacity:6];
    for( idx = 0; idx < 6; idx++) [tempStore insertObject:[rootProcessing integerString:0] atIndex:idx];
    // In what folloews, dictionaryKey will cycle through each parse code (in string format)
    for (dictionaryKey in parsedDetails)
    {
        currentDetail = [parsedDetails objectForKey:dictionaryKey];
        parseCode = [currentDetail parseCode];
        principalPart = [currentDetail principalPartCode];
        prevPCode = [[tempStore objectAtIndex:principalPart - 1] integerValue];
        if( prevPCode == 0 )
        {
            [tempStore replaceObjectAtIndex:principalPart - 1 withObject:dictionaryKey];
        }
        else
        {
            if( parseCode < prevPCode) [tempStore replaceObjectAtIndex:principalPart - 1 withObject:dictionaryKey];
        }
    }
    // At this point, tempStore will have either the lowest parseCode or 0 (zero) for each principal part
    bestParse = [[NSMutableArray alloc] init];
    for( idx = 0; idx < 6; idx++ )
    {
        dictionaryKey = [tempStore objectAtIndex:idx];
        if( [dictionaryKey intValue] == 0) [bestParse addObject:@""];
        else
        {
            currentDetail = [parsedDetails objectForKey:dictionaryKey];
            wordList = [[NSArray alloc] initWithArray:[currentDetail actualWordForms]];
            summaryEntry = [[NSMutableString alloc] initWithString:@""];
            numberCount = [wordList count];
            for( ndx = 0; ndx < numberCount; ndx++)
            {
                if( ndx == 0 ) [summaryEntry appendString:[wordList objectAtIndex:0]];
                else [summaryEntry appendFormat:@", %@", [wordList objectAtIndex:ndx]];
            }
            [bestParse addObject:[[NSString alloc] initWithString:summaryEntry]];
        }
    }
    isParseOrdered = true;
}

@end
