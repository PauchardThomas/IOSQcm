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


-(void)insert:(EntityCategory*)category{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:category.libelle forKey:@"libelle"];
    
    [appDelegate saveContext];
    
}
-(NSArray*) getAll {
    
    NSArray* categories = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:@"Category"
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
-(void)update:(NSManagedObject*)managedObject withCategory:(EntityCategory*)category {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:category.libelle forKey:@"libelle"];
    
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
