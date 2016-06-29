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
    [managedObject setValue:[NSNumber numberWithInteger:[question.qcm.id_server integerValue]] forKey:QuestionSqLiteAdapter.COL_ID_QCM];
    [managedObject setValue:[NSNumber numberWithInteger:[question.id_server integerValue]] forKey:QuestionSqLiteAdapter.COL_ID_SERVER];
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
-(NSArray*)getByQcm:(Qcm*)qcm {
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    
    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"qcm_id = %@",qcm.id_server];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QuestionSqLiteAdapter.ENTITY_QUESTION];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute query
    NSArray* questions = [context executeFetchRequest:request error:nil];
   // NSManagedObject* managedObject = [[context executeFetchRequest:request error:nil]objectAtIndex:0];
    
    return questions;
}

-(NSManagedObject*)getByIdServer:(Question*)question {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    
    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_server = %@",question.id_server];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QuestionSqLiteAdapter.ENTITY_QUESTION];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute query
    NSManagedObject* managedObject = nil;
    
    @try {
        managedObject =[[context executeFetchRequest:request error:nil]objectAtIndex:0];
        return managedObject;
    }@catch(NSException* e) {
        NSLog(@"%@",e);
    }
    
    
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
