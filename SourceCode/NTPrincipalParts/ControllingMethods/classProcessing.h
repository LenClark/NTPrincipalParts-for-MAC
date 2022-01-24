//
//  classProcessing.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface classProcessing : NSObject

@property (retain) NSArray *grammarBreakdown;
@property (nonatomic) NSInteger principalPartCode;

// Arrays containing classified Greek characters
@property (retain) NSArray *majiscules;
@property (retain) NSArray *miniscules;
@property (retain) NSArray *accentedChars;
@property (retain) NSArray *accentsRemoved;
@property (retain) NSArray *highGraves;
@property (retain) NSArray *lowGraves;
@property (retain) NSArray *allChars;
@property (retain) NSArray *allSimplified;
@property (retain) NSArray *translitChars1;
@property (retain) NSArray *translitChars2;
@property (retain) NSMutableDictionary *transliterationTable;

- (NSString *) integerString: (NSInteger) intValue;
- (NSString *) cleanWord: (NSString *) incomingWord;
- (NSString *) cleanTransliteratedWord: (NSString *) incomingWord;
- (NSString *) transliterateGreekWord: (NSString *) sourceWord;
- (NSString *) stripAll: (NSString *) incomingWord;
- (NSInteger) getNTParseInfo: (NSString *) inParseInfo;
- (NSInteger) getLXXParseInfo: (NSString *) inParseInfo;

@end

NS_ASSUME_NONNULL_END
