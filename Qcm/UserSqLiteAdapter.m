//
//  UserSqLiteAdapter.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "UserSqLiteAdapter.h"
#import "AppDelegate.h"
@implementation UserSqLiteAdapter

-(void)insert:(User*)user{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:user.username forKey:@"username"];
    [managedObject setValue:user.password forKey:@"password"];
    
    [appDelegate saveContext];
    
}
-(NSArray*) getAll {
    
    NSArray* users = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:@"User"
                                      inManagedObjectContext:context];
    
    //get all cities db object
    users = [context executeFetchRequest:fetchRequest error:nil];
    
    return users;
    
}
-(NSManagedObject*)getById:(NSManagedObject *)user {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // get by id
    NSManagedObject *managedObject = [context objectWithID:user.objectID];
    
    return managedObject;
    
}
-(void)update:(NSManagedObject*)managedObject withUser:(User*)user {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:user.username forKey:@"username"];
    [managedObject setValue:user.password forKey:@"password"];
    
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
