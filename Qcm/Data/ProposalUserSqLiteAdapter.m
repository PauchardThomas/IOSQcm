//
//  ProposalUserSqLiteAdapter.m
//  Qcm
//
//  Created by etudiant on 27/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "ProposalUserSqLiteAdapter.h"

@implementation ProposalUserSqLiteAdapter

+(NSString*) ENTITY_PROPOSAL_USER{return @"AnswerUser";}
+(NSString*) COL_USER_ID{return @"user_id";}
+(NSString*) COL_QCM_ID{return @"qcm_id";}
+(NSString*) COL_QUESTION_ID{return @"question_id";}
+(NSString*) COL_PROPOSAL_ID{return @"proposal_id";}

-(void)insert:(ProposalUser*)proposalUser {
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:ProposalUserSqLiteAdapter.ENTITY_PROPOSAL_USER inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:proposalUser.user_id forKey:ProposalUserSqLiteAdapter.COL_USER_ID];
    [managedObject setValue:proposalUser.qcm_id forKey:ProposalUserSqLiteAdapter.COL_QCM_ID];
    [managedObject setValue:proposalUser.question_id forKey:ProposalUserSqLiteAdapter.COL_QUESTION_ID];
    [managedObject setValue:proposalUser.proposal_id forKey:ProposalUserSqLiteAdapter.COL_PROPOSAL_ID];
    [appDelegate saveContext];
    
}
-(void)remove:(ProposalUser*)proposalUser {
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    //DB instance
    NSManagedObject* managedObject = [NSEntityDescription insertNewObjectForEntityForName:ProposalUserSqLiteAdapter.ENTITY_PROPOSAL_USER inManagedObjectContext:context];
    
    //delete table
    [managedObject setValue:proposalUser.user_id forKey:ProposalUserSqLiteAdapter.COL_USER_ID];
    [managedObject setValue:proposalUser.qcm_id forKey:ProposalUserSqLiteAdapter.COL_QCM_ID];
    [managedObject setValue:proposalUser.question_id forKey:ProposalUserSqLiteAdapter.COL_QUESTION_ID];
    [managedObject setValue:proposalUser.proposal_id forKey:ProposalUserSqLiteAdapter.COL_PROPOSAL_ID];
    
    [context deleteObject:managedObject];
    
}
-(NSManagedObject*)getBy:(NSNumber*)userId:(NSNumber*)questionId{
    
    //DB instance
    AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    // create filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"user_id == %@ AND proposal_id == %@",userId,questionId];
    
    //create query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:ProposalUserSqLiteAdapter.ENTITY_PROPOSAL_USER];
    
    //set filter to query
    //request.predicate = predicate;
    [request setPredicate:predicate];
    
    //get by id server
    NSManagedObject* managedObject = nil;
    @try {
        managedObject =[[context executeFetchRequest:request error:nil]objectAtIndex:0];
        return managedObject;
    }@catch(NSException* e) {
        NSLog(@"execption : %@",e);
        return nil;
    }
    
    return managedObject;
    
}
@end
