//
//  QuestionSqLiteAdapter.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionSqLiteAdapter.h"
#import "AppDelegate.h"

@implementation QuestionSqLiteAdapter

-(void)insert:(Question*)question{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:question.libelle forKey:@"libelle"];
    [managedObject setValue:question.points forKey:@"points"];
    [managedObject setValue:question.qcm.id forKey:@"id_qcm"];
    
    [appDelegate saveContext];
    
}
-(NSArray*) getAll {
    
    NSArray* questions = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:@"Question"
                                      inManagedObjectContext:context];
    
    //get all cities db object
    questions = [context executeFetchRequest:fetchRequest error:nil];
    
    return questions;
    
}
-(NSManagedObject*)getById:(NSManagedObject *)question {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // get by id
    NSManagedObject *managedObject = [context objectWithID:question.objectID];
    
    return managedObject;
    
}
-(void)update:(NSManagedObject*)managedObject withQuestion:(Question*)question {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:question.libelle forKey:@"libelle"];
    [managedObject setValue:question.points forKey:@"points"];
    [managedObject setValue:question.qcm.id forKey:@"id_qcm"];
    
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
