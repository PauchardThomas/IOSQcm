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
-(NSManagedObject*)insert:(Proposal*)proposal;
-(void)insert:(Proposal*)proposal withQuestion:(NSManagedObject*)question;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)proposal;
-(NSMutableArray*)getByQuestion:(Question*)question;
-(void)update:(NSManagedObject*)managedObject withProposal:(Proposal*)proposal;
-(void)remove:(NSManagedObject*)managedObject;

@end
