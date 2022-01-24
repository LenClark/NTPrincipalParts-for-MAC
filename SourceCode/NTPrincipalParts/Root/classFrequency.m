//
//  classFrequency.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 12/01/2022.
//

#import "classFrequency.h"

@implementation classFrequency

@synthesize listCount;

/*=================================================================================================*
 *                                                                                                 *
 *                                      listOfRootWords                                            *
 *                                      ===============                                            *
 *                                                                                                 *
 *  This is a list of root words of a given frequency.  We need to use classes because (at lower   *
 *    orders of use, in particular) we will have a number of words with the same frequency.  So,   *
 *    each frequency will be associated with a class, which will list one or more words that occur *
 *    that number of times                                                                         *
 *                                                                                                 *
 *  key:   a meaningless sequential key                                                            *
 *  value: the root word                                                                           *
 *                                                                                                 *
 *=================================================================================================*/
@synthesize listOfRootWords;

-(id) init
{
    self = [super init];
    listCount = 0;
    listOfRootWords = [[NSMutableDictionary alloc] init];
    return self;
}

- (void) addRootEntry: (NSString *) tRootName withMethodClass: (classProcessing *) freqMethods
{
    [listOfRootWords setObject:tRootName forKey:[freqMethods integerString:listCount]];
    listCount++;
}

- (NSString *) getRootNameByIndex: (NSInteger) index withMethodClass: (classProcessing *) freqMethods
{
    NSString *retrievedTRoot;

    retrievedTRoot = [listOfRootWords objectForKey:[freqMethods integerString:index]];
    if (retrievedTRoot == nil) return @"";
    return retrievedTRoot;
}

@end
