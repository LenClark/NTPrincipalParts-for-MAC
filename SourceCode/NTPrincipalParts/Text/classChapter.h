//
//  classChapter.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import <Foundation/Foundation.h>
#import "classVerse.h"

NS_ASSUME_NONNULL_BEGIN

@interface classChapter : NSObject

@property (nonatomic) NSInteger noOfVerses;
@property (retain) NSString *chapterRef;
@property (retain) NSMutableDictionary *verseList;
@property (retain) NSMutableDictionary *verseLookup;

- (classVerse *) addVerse: (NSString *) verseNo inSequence: (NSInteger) verseSeq;
- (NSString *) getVerseText: (NSInteger) verseSeq;
- (NSString *) getVerseRefBySequence: (NSInteger) seq;

@end

NS_ASSUME_NONNULL_END
