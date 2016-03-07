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

-(void)insert:(Proposal*)proposal{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:@"Proposal" inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:proposal.libelle forKey:@"libelle"];
    [managedObject setValue:[NSNumber numberWithBool:proposal.isAnswer] forKey:@"isAnswer"];
    [managedObject setValue:proposal.question.id forKey:@"question"];
    
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
    fetchRequest.entity = [NSEntityDescription entityForName:@"Proposal"
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
    [managedObject setValue:proposal.libelle forKey:@"libelle"];
    [managedObject setValue:[NSNumber numberWithBool:proposal.isAnswer] forKey:@"isAnswer"];
    [managedObject setValue:proposal.question.id forKey:@"question"];
    
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
