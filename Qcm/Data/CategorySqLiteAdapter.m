//
//  CategorySqLiteAdapter.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategorySqLiteAdapter.h"
#import "AppDelegate.h"

@implementation CategorySqLiteAdapter


+(NSString*) ENTITY_CATEGORY{return @"Category";}
+(NSString*) COL_LIBELLE{return @"libelle";}
+(NSString*) COL_ID_SERVER{return @"id_server";}

-(void)insert:(EntityCategory*)category{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:CategorySqLiteAdapter.ENTITY_CATEGORY inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:category.libelle forKey:CategorySqLiteAdapter.COL_LIBELLE];
    [managedObject setValue: [NSNumber numberWithInt:category.id_server] forKey:CategorySqLiteAdapter.COL_ID_SERVER];
    
    [appDelegate saveContext];
    
    NSManagedObjectID *idInserted = managedObject.objectID;
    NSLog(@"id inserted  %@: ",idInserted);

    
    
    
}
-(NSArray*) getAll {
    
    NSArray* categories = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:CategorySqLiteAdapter.ENTITY_CATEGORY
                                      inManagedObjectContext:context];
    
    //get all cities db object
    categories = [context executeFetchRequest:fetchRequest error:nil];
    
    return categories;
    
}
-(NSManagedObject*)getById:(NSManagedObject *)category {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // get by id
    NSManagedObject *managedObject = [context objectWithID:category.objectID];
    
    return managedObject;
    
}

-(NSManagedObject*)getByIdServer:(EntityCategory*)category {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    
    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_server = %i",category.id_server];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:CategorySqLiteAdapter.ENTITY_CATEGORY];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute query
    NSManagedObject* managedObject = [[context executeFetchRequest:request error:nil]objectAtIndex:0];
    
    return managedObject;
    
}
-(void)update:(NSManagedObject*)managedObject withCategory:(EntityCategory*)category {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:category.libelle forKey:CategorySqLiteAdapter.COL_LIBELLE];
    [managedObject setValue: [NSNumber numberWithInt:category.id_server] forKey:CategorySqLiteAdapter.COL_ID_SERVER];
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
