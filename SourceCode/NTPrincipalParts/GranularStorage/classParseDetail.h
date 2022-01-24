//
//  classParseDetail.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 12/01/2022.
//

#import <Foundation/Foundation.h>
#import "classProcessing.h"
#import "classReference.h"

NS_ASSUME_NONNULL_BEGIN

@interface classParseDetail : NSObject

@property (retain) classProcessing *parseProcessing;
@property (nonatomic) bool isFirstOccurrence;
@property (nonatomic) NSInteger ntAndLxxCode;
@property (nonatomic) NSInteger parseCode;
@property (nonatomic) NSInteger principalPartCode;
@property (nonatomic) NSInteger plainWordCount;
@property (nonatomic) NSInteger cleanWordCount;
@property (nonatomic) NSInteger referenceCount;
@property (retain) NSArray *grammarBreakdown;

// Stores for word forms
@property (retain) NSMutableArray *actualWordForms;
@property (retain) NSMutableArray *transliteratedWordForms;
@property (retain) NSMutableArray *cleanedWordForms;
@property (retain) NSMutableArray *transliteratedCleanedForms;
@property (retain) NSMutableArray *plainWordForms;
@property (retain) NSMutableArray *transliteratedPlainForms;
@property (retain) NSMutableDictionary *referenceList;
@property (retain) NSMutableDictionary *referenceControl;

- (void) addParseDetail: (NSString *) currentWord transliteratedVersion: (NSString *) tCurrentWord
                cleaned: (NSString *) cleanedForm transliteratedCleanForm: (NSString *) tCleanedForm
         withoutAccents: (NSString *) noAccent transliteratedNoAccents: (NSString *) tNoAccent
          havingPartCode: (NSInteger) pPartCode andParseCode: (NSInteger) pCode
            withBookName: (NSString *) inBook chapterReference: (NSString *) inChap verseRdeference: (NSString *) inVerse
                bookCode: (NSInteger) bookNo chapterSequence: (NSInteger) chapterSeq verseSequence: (NSInteger) verseSeq
        supportingClass: (classProcessing *) gkMethod andFlag: (bool) isFromNT;

@end

NS_ASSUME_NONNULL_END
