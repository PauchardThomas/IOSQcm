//
//  QuestionWSAdapter.h
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionWSAdapter : NSObject

// Send user answers to server
-(void)send:(NSString*)answers;

@end
