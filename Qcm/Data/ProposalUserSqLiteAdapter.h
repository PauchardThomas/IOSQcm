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
+(NSString*) ENTITY_PROPOSAL_USER;
+(NSString*) COL_USER_ID;
+(NSString*) COL_QCM_ID;
+(NSString*) COL_QUESTION_ID;
+(NSString*) COL_PROPOSAL_ID;
-(void)insert:(ProposalUser*)proposalUser;
-(void)remove:(ProposalUser*)proposalUser;
-(NSArray*) get:(NSNumber*)userId:(NSNumber*)qcmId;
-(NSManagedObject*)getBy:(NSNumber*)userId:(NSNumber*)questionId;
@end
