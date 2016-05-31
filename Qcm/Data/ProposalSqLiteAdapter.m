//
//  ProposalSqLiteAdapter.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "ProposalSqLiteAdapter.h"
#import "AppDelegate.h"

@implementation ProposalSqLiteAdapter

+(NSString*) ENTITY_PROPOSAL{return @"Proposal";}
+(NSString*) COL_LIBELLE{return @"libelle";}
+(NSString*) COL_ISANSWER{return @"isAnswer";}
+(NSString*) COL_QUESTION{return @"question";}
+(NSString*) COL_ID_SERVER{return @"id_server";}

-(void)insert:(Proposal*)proposal{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:ProposalSqLiteAdapter.ENTITY_PROPOSAL inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:proposal.libelle forKey:ProposalSqLiteAdapter.COL_LIBELLE];
    [managedObject setValue:[NSNumber numberWithBool:proposal.isAnswer] forKey:ProposalSqLiteAdapter.COL_ISANSWER];
    [managedObject setValue:proposal.question.id forKey:ProposalSqLiteAdapter.COL_QUESTION];
    [managedObject setValue: [NSNumber numberWithInt:proposal.id_server] forKey:ProposalSqLiteAdapter.COL_ID_SERVER];
    [appDelegate saveContext];
    
}
-(NSArray*) getAll {
    
    NSArray* proposals = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:ProposalSqLiteAdapter.ENTITY_PROPOSAL
                                      inManagedObjectContext:context];
    
    //get all cities db object
    proposals = [context executeFetchRequest:fetchRequest error:nil];
    
    return proposals;
    
}
-(NSManagedObject*)getById:(NSManagedObject *)proposal {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // get by id
    NSManagedObject *managedObject = [context objectWithID:proposal.objectID];
    
    return managedObject;
    
}
-(void)update:(NSManagedObject*)managedObject withProposal:(Proposal*)proposal {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:proposal.libelle forKey:ProposalSqLiteAdapter.COL_LIBELLE];
    [managedObject setValue:[NSNumber numberWithBool:proposal.isAnswer] forKey:ProposalSqLiteAdapter.COL_ISANSWER];
    [managedObject setValue:proposal.question.id forKey:ProposalSqLiteAdapter.COL_QUESTION];
    [managedObject setValue: [NSNumber numberWithInt:proposal.id_server] forKey:ProposalSqLiteAdapter.COL_ID_SERVER];
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
