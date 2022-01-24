//
//  frmProgress.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 24/01/2022.
//

#import "frmProgress.h"

@interface frmProgress ()

@end

@implementation frmProgress

@synthesize txtProgressMsg;
@synthesize progBarInitialisation;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void) incrementProgress: (NSString *) message
{
    [txtProgressMsg setStringValue:message];
    [progBarInitialisation incrementBy:1];
}

@end
