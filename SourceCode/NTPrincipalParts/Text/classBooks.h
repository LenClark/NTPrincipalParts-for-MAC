//
//  classBooks.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import <Foundation/Foundation.h>
#import "classChapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface classBooks : NSObject

// Data stored specifically for books
@property (nonatomic) BOOL isNTBook;
@property (nonatomic) NSInteger noOfChapters;
@property (nonatomic) NSInteger actualBookNumber;
@property (retain) NSString *bookName;
@property (retain) NSString *shortName;
@property (retain) NSString *fileName;

// Variables required to enable navigation of subsidiary structures
@property (retain) NSMutableDictionary *chapterList;
@property (retain) NSMutableDictionary *chapterReferenceList;

- (classChapter *) addChapter: (NSString *) chapterNo ofSequenceNo: (NSInteger) chapterSeq;
- (classChapter *) getChapterBySequence: (NSInteger) seq;
- (NSString *) getChapterRefBySequence: (NSInteger) seq;

@end

NS_ASSUME_NONNULL_END
