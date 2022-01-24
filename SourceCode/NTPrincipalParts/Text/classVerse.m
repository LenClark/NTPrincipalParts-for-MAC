//
//  classVerse.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import "classVerse.h"

@implementation classVerse

@synthesize verseRef;
@synthesize textOfVerse;

-(id) init
{
    self = [super init];
    textOfVerse = [[NSMutableString alloc] initWithString:@""];
    return self;
}

- (void) addWord: (NSString *) word
withLeadingChars: (NSString *) preChars
  followingChars: (NSString *) followingChars
  andPunctuation: (NSString *) punctuation
{
    if ([textOfVerse length] == 0) [textOfVerse appendFormat:@"%@%@%@%@", preChars, word, followingChars, punctuation];
    else [textOfVerse appendFormat:@" %@%@%@%@", preChars, word, followingChars, punctuation];
}

@end
