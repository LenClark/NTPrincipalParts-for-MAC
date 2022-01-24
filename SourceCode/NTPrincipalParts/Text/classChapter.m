/*==================================================================================*
 *                                                                                  *
 *                                 classChapter                                     *
 *                                 ============                                     *
 *                                                                                  *
 *  In the LXX we have two specific phenomena:                                      *
 *    (a) consecutive verses such as 22, 22a, 22b ...                               *
 *    (b) chapters can be out of sequence (e.g. chapter 24 follwed by chapter 30)   *
 *    (c) out-of-sequence repeats of chapters - e.g. chapters 24, 30, 24 (although  *
 *        _verses_ are never repeated within chapters - other than point a)         *
 *                                                                                  *
 *  So, our processing must cater for this.                                         *
 *                                                                                  *
 *  All access will be by sequential numbers, created in the code.  However, we     *
 *    need to be able to identify the correct chapter reference from the sequence.  *
 *    So, we will also reference a chapter selection class that allows us to        *
 *    recover the correct chapter sequence number from a chapter reference and      *
 *    verse reference.                                                              *
 *                                                                                  *
 *  Date: 9 Jan 2022                                                                *
 *  Author: Len Clark                                                               *
 *                                                                                  *
 *==================================================================================*/

#import "classChapter.h"

@implementation classChapter

@synthesize noOfVerses;
@synthesize chapterRef;

/*----------------------------------------------------------------------------------*
 *                                                                                  *
 *                                 verseList                                        *
 *                                 ---------                                        *
 *                                                                                  *
 *  Identify the classVerse instance associated with the verse reference given in   *
 *    source data.                                                                  *
 *                                                                                  *
 *  Key:   the provided verse reference (NSString)                                  *
 *  Value: the associated classVerse instance                                       *
 *                                                                                  *
 *----------------------------------------------------------------------------------*/
@synthesize verseList;

/*----------------------------------------------------------------------------------*
 *                                                                                  *
 *                                verseLookup                                       *
 *                                -----------                                       *
 *                                                                                  *
 *  Identify the provided verse reference associated with the sequence number       *
 *    generated within the code.                                                    *
 *                                                                                  *
 *  Key:   the artificially generated sequence number (NSInteger)                   *
 *  Value: the verse reference provided by the source data                          *
 *                                                                                  *
 *----------------------------------------------------------------------------------*/
@synthesize verseLookup;

-(id) init
{
    self = [super init];
    noOfVerses = 0;
    verseList = [[NSMutableDictionary alloc] init];
    verseLookup = [[NSMutableDictionary alloc] init];
    return self;
}

- (classVerse *) addVerse: (NSString *) verseNo inSequence: (NSInteger) verseSeq
{
    classVerse *currentVerse;

    currentVerse = [verseList objectForKey:verseNo];
    if (currentVerse == nil)
    {
        currentVerse = [[classVerse alloc] init];
        [verseList setValue:currentVerse forKey:verseNo];
        [verseLookup setValue:verseNo forKey:[[NSString alloc] initWithFormat:@"%ld", verseSeq]];
        [currentVerse setVerseRef:verseNo];
        if (verseSeq > noOfVerses) noOfVerses = verseSeq;
    }
    return currentVerse;
}

- (NSString *) getVerseText: (NSInteger) verseSeq
{
    NSString *verseRef;
    classVerse *currentVerse;

    verseRef = [verseLookup objectForKey:[[NSString alloc] initWithFormat:@"%ld", verseSeq]];
    if (verseRef != nil)
    {
        currentVerse = [verseList objectForKey:verseRef];
    }
    if (currentVerse == nil) return @"";
    else return [currentVerse textOfVerse];
}

- (NSString *) getVerseRefBySequence: (NSInteger) seq
{
    NSString *verseRef;

    verseRef = [verseLookup objectForKey:[[NSString alloc] initWithFormat:@"%ld", seq]];
    return verseRef;
}

@end
