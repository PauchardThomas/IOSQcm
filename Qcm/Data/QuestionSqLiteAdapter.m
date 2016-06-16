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

+(NSString*) ENTITY_QUESTION{return @"Question";}
+(NSString*) COL_LIBELLE{return @"libelle";}
+(NSString*) COL_POINTS{return @"points";}
+(NSString*) COL_ID_QCM{return @"qcm_id";}
+(NSString*) COL_ID_SERVER{return @"id_server";}

-(NSManagedObject*)insert:(Question*)question{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:QuestionSqLiteAdapter.ENTITY_QUESTION inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:question.libelle forKey:QuestionSqLiteAdapter.COL_LIBELLE];
    [managedObject setValue:question.points forKey:QuestionSqLiteAdapter.COL_POINTS];
    [managedObject setValue:[NSNumber numberWithInt:question.qcm.id_server] forKey:QuestionSqLiteAdapter.COL_ID_QCM];
    [managedObject setValue: [NSNumber numberWithInt:question.id_server] forKey:QuestionSqLiteAdapter.COL_ID_SERVER];
    [appDelegate saveContext];
    
    return managedObject;
    
}
-(NSArray*) getAll {
    
    NSArray* questions = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:QuestionSqLiteAdapter.ENTITY_QUESTION
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
    [managedObject setValue:question.libelle forKey:QuestionSqLiteAdapter.COL_LIBELLE];
    [managedObject setValue:question.points forKey:QuestionSqLiteAdapter.COL_POINTS];
    [managedObject setValue:question.qcm.id forKey:QuestionSqLiteAdapter.COL_ID_QCM];
    
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
