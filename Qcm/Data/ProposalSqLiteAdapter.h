//
//  ProposalSqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Proposal.h"
#import "Question.h"
@interface ProposalSqLiteAdapter : NSObject

+(NSString*) ENTITY_PROPOSAL;
+(NSString*) COL_LIBELLE;
+(NSString*) COL_ISANSWER;
+(NSString*) COL_QUESTION;
+(NSString*) COL_ID_SERVER;
// Insert proposal
-(NSManagedObject*)insert:(Proposal*)proposal;
// Get all proposals
-(NSArray*) getAll;
// Get proposal by id
-(NSManagedObject*)getById:(NSManagedObject *)proposal;
//Get proposal by question
-(NSMutableArray*)getByQuestion:(Question*)question;
// Update proposal
-(void)update:(NSManagedObject*)managedObject withProposal:(Proposal*)proposal;
// Remove proposal
-(void)remove:(NSManagedObject*)managedObject;

@end
