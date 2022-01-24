//
//  classReference.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 20/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface classReference : NSObject

@property (nonatomic) NSInteger bookNo;
@property (nonatomic) NSInteger chapterSeq;
@property (nonatomic) NSInteger verseSeq;
@property (retain) NSString *bookName;
@property (retain) NSString *chapter;
@property (retain) NSString *verse;

@end

NS_ASSUME_NONNULL_END
