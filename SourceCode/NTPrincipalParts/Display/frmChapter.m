//
//  frmChapter.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 21/01/2022.
//

#import "frmChapter.h"

@interface frmChapter ()

@end

@implementation frmChapter

@synthesize chapterWindow;
@synthesize parentController;
@synthesize grandparentController;
@synthesize txtChapter;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void) processReference: (NSString *) fullreference forBook: (NSString *) bookName andChapter: (NSString *) chapter including: (NSDictionary *) listOfBooks procsLoc: (classProcessing *) dispProcs
{
    bool isFound = false, isFirst = true;
    NSInteger idx, noOfBooks, noOfChapters, noOfVerses;
    NSString *candidateName, *verseText, *verse;
    NSArray *splitReference, *verseList;
    NSMutableAttributedString *chapterText, *fullChapterText;
    NSFont *boldFont, *normalFont;
    classBooks *currentBook;
    classChapter *currentChapter;
    
    normalFont = [NSFont fontWithName:@"Times New Roman" size:16];
    boldFont = [NSFont fontWithName:@"Times New Roman Bold" size:16];

    [[self window] setTitle:[[NSString alloc] initWithFormat:@"%@ %@", bookName, chapter]];
    noOfBooks = [listOfBooks count];
    for( idx = 1; idx <= noOfBooks; idx++ )
    {
        currentBook = [listOfBooks objectForKey:[dispProcs integerString:idx]];
        if( currentBook == nil) continue;
        candidateName = [[NSString alloc] initWithString:[currentBook bookName]];
        if( [bookName compare:candidateName] == NSOrderedSame )
        {
            isFound = true;
            break;
        }
    }
    if( isFound )
    {
        isFound = false;
        noOfChapters = [currentBook noOfChapters];
        for( idx = 0; idx < noOfChapters; idx++)
        {
            currentChapter = [currentBook getChapterBySequence:idx];
            if( currentChapter == nil) continue;
            candidateName = [[NSString alloc] initWithString:[currentChapter chapterRef]];
            if( [chapter compare:candidateName] == NSOrderedSame )
            {
                isFound = true;
                break;
            }
        }
        if( isFound )
        {
            // Before we get the text, we need a list of verses in the reference.  In order to get these, we need
            //  to decompose the reference
            splitReference = [fullreference componentsSeparatedByString:@":"];
            if( [splitReference count] < 2) verseList = [[NSArray alloc] init];
            else
            {
                verseList = [[[NSString alloc] initWithString:[splitReference objectAtIndex:1]] componentsSeparatedByString:@", "];
            }
            // We now have book and chapter
            noOfVerses = [currentChapter noOfVerses];
            for( idx = 1; idx <= noOfVerses; idx++)
            {
                verse = [currentChapter getVerseRefBySequence:idx];
                verseText = [currentChapter getVerseText:idx];
                chapterText = [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"%@: %@", verse, verseText]];
                if( [verseList containsObject:verse] ) [chapterText addAttribute:NSFontAttributeName value:boldFont range:(NSMakeRange(0, [chapterText length]))];
                else [chapterText addAttribute:NSFontAttributeName value:normalFont range:(NSMakeRange(0, [chapterText length]))];
                if( isFirst)
                {
                    fullChapterText = [[NSMutableAttributedString alloc] initWithAttributedString:chapterText];
                    isFirst = false;
                }
                else
                {
                    [fullChapterText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
                    [fullChapterText appendAttributedString:chapterText];
                }
            }
            [[txtChapter textStorage] setAttributedString:fullChapterText];
        }
    }
}

- (IBAction)doBackToBase:(id)sender
{
    [grandparentController close];
    [parentController close];
    [self close];
}

- (IBAction)doClose:(id)sender
{
    [self close];
}

@end
