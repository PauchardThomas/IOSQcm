//
//  ProposalUserSqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 27/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProposalUser.h"
#import "AppDelegate.h"

@interface ProposalUserSqLiteAdapter : NSObject

// proposal user entity
+(NSString*) ENTITY_PROPOSAL_USER;
// Answer user id
+(NSString*) COL_USER_ID;
// Answer  qcm id
+(NSString*) COL_QCM_ID;
// Answer question id
+(NSString*) COL_QUESTION_ID;
// Answer proposal id
+(NSString*) COL_PROPOSAL_ID;
// insert user answers
-(void)insert:(ProposalUser*)proposalUser;
// remove user answers
-(void)remove:(ProposalUser*)proposalUser;
// get answers by user and qcm
-(NSArray*) get:(NSNumber*)userId:(NSNumber*)qcmId;
// Get answers by user and question
-(NSManagedObject*)getBy:(NSNumber*)userId:(NSNumber*)questionId;
@end
