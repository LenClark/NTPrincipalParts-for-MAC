//
//  classRoot.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 12/01/2022.
//

#import <Foundation/Foundation.h>
#import "classProcessing.h"
#import "classParseDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface classRoot : NSObject

@property (nonatomic) bool isParseOrdered;
@property (nonatomic) NSInteger frequencyInNT;
@property (nonatomic) NSInteger frequencyInOT;
@property (nonatomic) NSInteger parseCount;
@property (retain) NSString *rootWord;
@property (retain) NSMutableDictionary *parsedDetails;
@property (retain) NSMutableArray *bestParse;
@property (retain) classProcessing *rootProcessing;

- (void) addRootInformation: (bool) isNT ofWordAsUsed: (NSString *) specificWord transliteratedVersion: (NSString *) tSpecificWord
                    cleaned: (NSString *) cleanedWord transliteratedCleanedForm: (NSString *) tCleanedWord
         wordWithoutAccents: (NSString *) noAccent transliteredNoAccents: (NSString *) tNoAccent
              withParseCode: (NSInteger) parseCode andPrincipalPartCode: (NSInteger) principalPartCode
                   bookName: (NSString *) bookName chapterReference: (NSString *) chapter verseReference: (NSString *) verse
                   bookCode: (NSInteger) bookNo chapterSequence: (NSInteger) chapterSeq verseSequence: (NSInteger) verseSeq
              breakdownCode: (NSArray *) inBreakdown
                 processing: (classProcessing *) gkMethod;

- (void) orderByParseCode;

@end

NS_ASSUME_NONNULL_END
