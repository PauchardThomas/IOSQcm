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

+(NSString*) ENTITY_USER{return @"User";}
+(NSString*) COL_USERNAME {return @"username";}
+(NSString*) COL_PASSWORD {return @"password";}
+(NSString*) COL_ID_SERVER{return @"id_server";}

-(NSManagedObjectID*)insert:(User*)user{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:UserSqLiteAdapter.ENTITY_USER inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:user.username forKey:UserSqLiteAdapter.COL_USERNAME];
    [managedObject setValue:user.password forKey:UserSqLiteAdapter.COL_PASSWORD];
    [managedObject setValue: [NSNumber numberWithInt:user.id_server] forKey:UserSqLiteAdapter.COL_ID_SERVER];
    [appDelegate saveContext];
    
    return managedObject.objectID;
    
}
-(NSArray*) getAll {
    
    NSArray* users = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:UserSqLiteAdapter.ENTITY_USER
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
-(NSManagedObject*)getByIdServer:(int)id_server {
    
    //DB instance
    AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    // create filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_server = %d",id_server];
    
    //create query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    //set filter to query
    request.predicate = predicate;
    
    //get by id server
    NSManagedObject* managedObject = nil;
    @try {
        managedObject =[[context executeFetchRequest:request error:nil]objectAtIndex:0];
        return managedObject;
    }@catch(NSException* e) {
        
    }
    
    return managedObject;
    

}
-(void)update:(NSManagedObject*)managedObject withUser:(User*)user {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:user.username forKey:UserSqLiteAdapter.COL_USERNAME];
    [managedObject setValue:user.password forKey:UserSqLiteAdapter.COL_PASSWORD];
    
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}

@end
