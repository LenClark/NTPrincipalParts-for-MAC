//
//  classVerse.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface classVerse : NSObject

@property (retain) NSString *verseRef;
@property (retain) NSMutableString *textOfVerse;

- (void) addWord: (NSString *) word
withLeadingChars: (NSString *) preChars
  followingChars: (NSString *) followingChars
  andPunctuation: (NSString *) punctuation;

@end

NS_ASSUME_NONNULL_END
