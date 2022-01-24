/*=========================================================================================================*
 *                                                                                                         *
 *                                               classBooks                                                *
 *                                               ==========                                                *
 *                                                                                                         *
 *  This class serves two purposes:                                                                        *
 *    (a) simple repository of information about each book of the Bible and the relevant text file;        *
 *    (b) the root class for accessing references (book --> chapter --> verse)                             *
 *                                                                                                         *
 *  This second purpose carries some significant implications.  In the LXX we have two specific phenomena: *
 *    (a) consecutive verses such as 22, 22a, 22b ...                                                      *
 *    (b) chapters can be out of sequence (e.g. chapter 24 follwed by chapter 30)                          *
 *    (c) out-of-sequence repeats of chapters - e.g. chapters 24, 30, 24 (although _verses_ are never      *
 *        repeated within chapters - other than point a)                                                   *
 *                                                                                                         *
 *  So, our processing must cater for this.                                                                *
 *                                                                                                         *
 *  All access will be by sequential numbers, created in the code.  However, we need to be able to         *
 *    identify the correct chapter reference from the sequence. So, we will also reference a chapter       *
 *    selection class that allows us to recover the correct chapter sequence number from a chapter         *
 *    reference and verse reference.                                                                       *
 *                                                                                                         *
 *  Created: 8 Jan 2022                                                                                    *
 *  Author: Len Clark                                                                                      *
 *                                                                                                         *
 *=========================================================================================================*/

#import "classBooks.h"

@implementation classBooks

@synthesize isNTBook;
@synthesize noOfChapters;
@synthesize actualBookNumber;
@synthesize bookName;
@synthesize shortName;
@synthesize fileName;

/*---------------------------------------------------------------------------------------------------------*
 *                                                                                                         *
 *                                              chapterList                                                *
 *                                              -----------                                                *
 *                                                                                                         *
 *  This list allows us to store and identify a specific chapter within a book from its internally         *
 *    generated sequence number.                                                                           *
 *                                                                                                         *
 *  Key:   The sequence number;                                                                            *
 *  Value: The address of the instance of the relevant chapter.                                            *
 *                                                                                                         *
 *---------------------------------------------------------------------------------------------------------*/
@synthesize chapterList;

/*---------------------------------------------------------------------------------------------------------*
 *                                                                                                         *
 *                                           chapterReferenceList                                          *
 *                                           --------------------                                          *
 *                                                                                                         *
 *  This list allows us to store the chapter number as provided by the source data (in string form).       *
 *    While the sequence number is a simple sequence, chapter references may be out of sequence and may    *
 *    even be repeated after a break.                                                                      *
 *                                                                                                         *
 *  Key:   The sequence number;                                                                            *
 *  Value: The string chapter number as provided by the source data.                                       *
 *                                                                                                         *
 *---------------------------------------------------------------------------------------------------------*/
@synthesize chapterReferenceList;

-(id) init
{
    self = [super init];
    chapterList = [[NSMutableDictionary alloc] init];
    chapterReferenceList = [[NSMutableDictionary alloc] init];
    noOfChapters = 0;
    return self;
}

- (classChapter *) addChapter: (NSString *) chapterNo ofSequenceNo: (NSInteger) chapterSeq
{
    classChapter *currentChapter;

    currentChapter = [chapterList objectForKey:[[NSString alloc] initWithFormat:@"%ld", chapterSeq]];
    if (currentChapter == nil)
    {
        currentChapter = [[ classChapter alloc] init];
        [chapterList setObject:currentChapter forKey:[[NSString alloc] initWithFormat:@"%ld", chapterSeq]];
        [chapterReferenceList setObject:[[NSString alloc] initWithString: chapterNo] forKey:[[NSString alloc] initWithFormat:@"%ld", chapterSeq]];
        [currentChapter setChapterRef:chapterNo];
        if (chapterSeq > noOfChapters) noOfChapters = chapterSeq;
    }
    return currentChapter;
}

- (classChapter *) getChapterBySequence: (NSInteger) seq
{
    classChapter *currentChapter;

    currentChapter = [chapterList objectForKey:[[NSString alloc] initWithFormat:@"%ld", seq]];
    return currentChapter;
}

- (NSString *) getChapterRefBySequence: (NSInteger) seq
{
    NSString *chapRef;

    chapRef = [chapterReferenceList objectForKey:[[NSString alloc] initWithFormat:@"%ld", seq]];
    return chapRef;
}

@end
