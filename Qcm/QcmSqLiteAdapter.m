//
//  QcmSqLiteAdapter.m
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmSqLiteAdapter.h"
#import "AppDelegate.h"

@implementation QcmSqLiteAdapter

-(void)insert:(Qcm*)qcm{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:@"Qcm" inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:qcm.libelle forKey:@"libelle"];
    [managedObject setValue:qcm.datePubli forKey:@"datePubli"];
    [managedObject setValue:qcm.dateFin forKey:@"dateFin"];
    [managedObject setValue:qcm.nbPoints forKey:@"nbPoints"];
    [managedObject setValue:qcm.category.id forKey:@"id_category"];
    
    [appDelegate saveContext];
    
}
-(NSArray*) getAll {
    
    NSArray* qcms = [NSArray new];
    
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:@"Qcm"
                                      inManagedObjectContext:context];
    
    //get all cities db object
    qcms = [context executeFetchRequest:fetchRequest error:nil];
    
    return qcms;
    
}
-(NSManagedObject*)getById:(NSManagedObject *)qcm {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    // get by id
    NSManagedObject *managedObject = [context objectWithID:qcm.objectID];
    
    return managedObject;
    
}
-(void)update:(NSManagedObject*)managedObject withQcm:(Qcm*)qcm {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:qcm.libelle forKey:@"libelle"];
    [managedObject setValue:qcm.datePubli forKey:@"datePubli"];
    [managedObject setValue:qcm.dateFin forKey:@"dateFin"];
    [managedObject setValue:qcm.nbPoints forKey:@"nbPoints"];
    [managedObject setValue:qcm.category.id forKey:@"id_category"];
    
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}


@end
