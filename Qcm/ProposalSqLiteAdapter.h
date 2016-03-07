//
//  ProposalSqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Proposal.h"

@interface ProposalSqLiteAdapter : NSObject

-(void)insert:(Proposal*)proposal;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)proposal;
-(void)update:(NSManagedObject*)managedObject withProposal:(Proposal*)proposal;
-(void)remove:(NSManagedObject*)managedObject;

@end
