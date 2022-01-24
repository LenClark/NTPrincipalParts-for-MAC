/*======================================================================================================================*
 *                                                                                                                      *
 *                                                 classParseDetail                                                     *
 *                                                 ================                                                     *
 *                                                                                                                      *
 *  This class will instantiate a specific grammatical element of a verb. So, for example, there will be a single entry *
 *     for present imperative active singular and another for aorist active infinitive.                                 *
 *                                                                                                                      *
 *  The class contains the following data:                                                                              *
 *                                                                                                                      *
 *  specificWordForm: In theory, this ought always to have only a single entry but, in practice, occurrences can vary   *
 *                    in accent and, rarely, dialectical variation.  There can also be grammatical variations (for      *
 *                    example, omission of the final sigma before a following vowel).                                   *
 *  plainWordForm:    This is simply the plain form version of each specific word form (i.e. no accents, etc but does   *
 *                    include breathings).  *These* are the bases of deciding which specific words are valid.           *
 *                                                                                                                      *
 *  Date: 9 Jan 2022                                                                                                    *
 *  Author: Len Clark                                                                                                   *
 *                                                                                                                      *
 *======================================================================================================================*/

#import "classParseDetail.h"

@implementation classParseDetail

@synthesize isFirstOccurrence;
@synthesize parseCode;
@synthesize principalPartCode;
@synthesize plainWordCount;
@synthesize cleanWordCount;
@synthesize referenceCount;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                                   ntAndLxxCode                                                       *
 *                                                   ------------                                                       *
 *                                                                                                                      *
 *  This tells us whether the form is only found in the NT, only found in the LXX or found in both.  The code telling   *
 *     us this is:                                                                                                      *
 *                                                                                                                      *
 *    Code                                            Meaning                                                           *
 *                                                                                                                      *
 *     0    Not allocated to any text                                                                                   *
 *     1    Only found in the New Testament                                                                             *
 *     2    Only found in the LXX                                                                                       *
 *     3    Found in both                                                                                               *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize ntAndLxxCode;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                                  actualWordForms                                                     *
 *                                                  ===============                                                     *
 *                                                                                                                      *
 *  This is the form of the word which we are actually interested in.  It will vary for different grammatical functions *
 *     - e.g. 1st person singular present indicative will be different from second person.  Each class instance is for  *
 *     a specific "grammatical function".  However, in some cases there may be several variants of the same grammatical *
 *     function - the same parse code.  So, the list, specificWordForm, will capture one or more forms of that unit.    *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize actualWordForms;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                               transliteratedWordForms                                                *
 *                                               =======================                                                *
 *                                                                                                                      *
 *  As actualWordForms but the transliterated version.                                                                  *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize transliteratedWordForms;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                                  cleanedWordForms                                                    *
 *                                                  ================                                                    *
 *                                                                                                                      *
 *  This matches actualWordForms but contains cleaned versions - e.g. removed initial majiscules or occurrences of a    *
 *    second accent.  Since these are _not_ used for the actual text, these are the elements we are really interested   *
 *    in.                                                                                                               *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize cleanedWordForms;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                             transliteratedCleanedForms                                               *
 *                                             ==========================                                               *
 *                                                                                                                      *
 *  This matches cleanedWordForms but transliterated.                                                                   *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize transliteratedCleanedForms;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                                   plainWordForms                                                     *
 *                                                   ==============                                                     *
 *                                                                                                                      *
 *  The simplified ("plain") form of the current word form is added to this list.  So, future occurrences can be        *
 *     compared with it to assess whether the form has occurred before.                                                 *
 *                                                                                                                      *
 *  We need to get rid of extraneous character furniture for several reasons:                                           *
 *     (a) most significant, for some characters (notably vowels with accute accents) there are potentially two Unicode *
 *           representations.  This means that words that are visually identical may have different electronic forms.   *
 *           Stripping the accents will remove this anomaly.                                                            *
 *     (b) some words may take varying accents when used in varying contexts.  This process will also remove their      *
 *           effect.                                                                                                    *
 *                                                                                                                      *
 *  Note: we do _not_ key these entries on the parse code because the parse code may have several different forms.  So, *
 *          this process allows us to handle variations in a given parse code.                                          *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize plainWordForms;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                               transliteratedPlainForms                                               *
 *                                               ========================                                               *
 *                                                                                                                      *
 *  As plainWordForms but transliterated.                                                                               *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize transliteratedPlainForms;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                                   referenceList                                                      *
 *                                                   =============                                                      *
 *                                                                                                                      *
 *  Any specific word form (keyed on a parse code) can have multiple occurrences in the Bible - i.e. it is found at     *
 *     multiple references. This dictionary manages this one to many relationship.                                      *
 *                                                                                                                      *
 *  Key:   A meaningless, sequential integer (soe we also need to store the total count of references for the parse     *
 *           code.                                                                                                      *
 *  Value: The address of a classReference instance                                                                     *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize referenceList;

/*----------------------------------------------------------------------------------------------------------------------*
 *                                                                                                                      *
 *                                                  referenceControl                                                    *
 *                                                  ================                                                    *
 *                                                                                                                      *
 *  This is the complement of referenceList: it allows us to find the index of a specific reference from the String     *
 *     form of the parse code.                                                                                          *
 *                                                                                                                      *
 *  Key:   The parse code (in string form)                                                                              *
 *  Value: The integer key for referenceList                                                                            *
 *                                                                                                                      *
 *----------------------------------------------------------------------------------------------------------------------*/
@synthesize referenceControl;

/*=========================================================================*
 *   grammarBreakdown:                                                     *
 *   ================                                                      *
 *   Stores the code value for each parse point (e.g. 1/2/3rd person,      *
 *     sing/plur, tense, etc.).  Items (positions in Tuple):               *
 *                                                                         *
 *      0   Person (values 0 to 3)                                         *
 *      1   Number (values 1 = singular, 2 = plural)                       *
 *      2   Case (values 1 to 5 and include vocative [=2])                 *
 *      3   Gender (values 1 to 3)                                         *
 *      4   Tense (values 1 to 6)                                          *
 *      5   Mood (values 1 to 6)                                           *
 *      6   Voice (values 1 to 3)                                          *
 *      7   Comparative (=1)/Superlative (=2)                              *
 *=========================================================================*/
@synthesize grammarBreakdown;

@synthesize parseProcessing;

-(id) init
{
    self = [super init];
    plainWordCount = 0;
    cleanWordCount = 0;
    referenceCount = 0;
    parseCode = 0;
    isFirstOccurrence = true;
    actualWordForms = [[NSMutableArray alloc] init];
    cleanedWordForms = [[NSMutableArray alloc] init];
    plainWordForms = [[NSMutableArray alloc] init];
    transliteratedWordForms = [[NSMutableArray alloc] init];
    transliteratedCleanedForms = [[NSMutableArray alloc] init];
    transliteratedPlainForms = [[NSMutableArray alloc] init];
    referenceControl = [[NSMutableDictionary alloc] init];
    referenceList = [[NSMutableDictionary alloc] init];
    return self;
}

- (void) addParseDetail: (NSString *) currentWord transliteratedVersion: (NSString *) tCurrentWord
                cleaned: (NSString *) cleanedForm transliteratedCleanForm: (NSString *) tCleanedForm
         withoutAccents: (NSString *) noAccent transliteratedNoAccents: (NSString *) tNoAccent
          havingPartCode: (NSInteger) pPartCode andParseCode: (NSInteger) pCode
            withBookName: (NSString *) inBook chapterReference: (NSString *) inChap verseRdeference: (NSString *) inVerse
                bookCode: (NSInteger) bookNo chapterSequence: (NSInteger) chapterSeq verseSequence: (NSInteger) verseSeq
         supportingClass: (classProcessing *) gkMethod andFlag: (bool) isFromNT
{
    NSString *refString, *testValue;
    classReference *reference;

    if (isFromNT)
    {
        if (ntAndLxxCode == 0) ntAndLxxCode = 1;
    }
    else
    {
        if (ntAndLxxCode < 2) ntAndLxxCode += 2;
    }
    if( isFirstOccurrence )
    {
        parseProcessing = gkMethod;
        principalPartCode = pPartCode; // I.e. which of the principal part categories the current form belongs to
        parseCode = pCode;  // I.e. the integer representation of the source parse code
        isFirstOccurrence = false;
    }
    if (! [transliteratedPlainForms containsObject:tNoAccent])
    {
        // Does our list of words contain the stripped word.  If not, it's a first!
        [plainWordForms addObject:noAccent];
        [transliteratedPlainForms addObject:tNoAccent];
        // We also want the accented word but *not* if it has graves or more than one accent
        if( ! [transliteratedCleanedForms containsObject:tCleanedForm])
        {
            [cleanedWordForms addObject:cleanedForm];
            [transliteratedCleanedForms addObject:tCleanedForm];
            [actualWordForms addObject:currentWord];
            [transliteratedWordForms addObject:tCurrentWord];
            cleanWordCount++;
        }
        plainWordCount++;
    }
    refString = [[NSString alloc] initWithFormat:@"%@ %@:%@", inBook, inChap, inVerse];
    testValue = [referenceControl objectForKey:refString];
    if (testValue != nil) return;
    // So, if we get here, it is a new reference
    reference = [[classReference alloc] init];
    [reference setBookName:inBook];
    [reference setChapter:inChap];
    [reference setVerse:inVerse];
    [reference setBookNo:bookNo];
    [reference setChapterSeq:chapterSeq];
    [reference setVerseSeq:verseSeq];
    [referenceControl setObject:[[NSString alloc] initWithFormat:@"%ld", referenceCount] forKey:refString];
    [referenceList setObject:reference forKey:[[NSString alloc] initWithFormat:@"%ld", referenceCount]];
    referenceCount++;
}

@end
