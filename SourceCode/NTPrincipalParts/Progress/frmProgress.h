//
//  frmProgress.h
//  NTPrincipalParts
//
//  Created by Leonard Clark on 24/01/2022.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface frmProgress : NSWindowController

@property (retain) IBOutlet NSTextField *txtProgressMsg;
@property (retain) IBOutlet NSProgressIndicator *progBarInitialisation;

- (void) incrementProgress: (NSString *) message;

@end

NS_ASSUME_NONNULL_END
