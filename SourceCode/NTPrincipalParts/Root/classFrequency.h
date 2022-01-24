//
//  classFrequency.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 12/01/2022.
//

#import <Foundation/Foundation.h>
#import "classProcessing.h"

NS_ASSUME_NONNULL_BEGIN

@interface classFrequency : NSObject

@property (nonatomic) NSInteger listCount;
@property (retain) NSMutableDictionary *listOfRootWords;

- (void) addRootEntry: (NSString *) tRootName withMethodClass: (classProcessing *) freqMethods;
- (NSString *) getRootNameByIndex: (NSInteger) index withMethodClass: (classProcessing *) freqMethods;

@end

NS_ASSUME_NONNULL_END
