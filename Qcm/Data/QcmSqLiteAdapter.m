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

+(NSString*) ENTITY_QCM{return @"Qcm";}
+(NSString*) COL_LIBELLE{return @"libelle";}
+(NSString*) COL_DATE_PUBLI{return @"datePubli";}
+(NSString*) COL_DATE_FIN{return @"dateFin";}
+(NSString*) COL_NB_POINTS{return @"nbPoints";}
+(NSString*) COL_ID_CATEGORY{return @"id_category";}
+(NSString*) COL_ID_SERVER{return @"id_server";}

-(void)insert:(Qcm*)qcm{
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //get table
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:QcmSqLiteAdapter.ENTITY_QCM inManagedObjectContext:context];
    
    //Insert table
    [managedObject setValue:qcm.libelle forKey:QcmSqLiteAdapter.COL_LIBELLE];
    [managedObject setValue:qcm.datePubli forKey:QcmSqLiteAdapter.COL_DATE_PUBLI];
    [managedObject setValue:qcm.dateFin forKey:QcmSqLiteAdapter.COL_DATE_FIN];
    [managedObject setValue:qcm.nbPoints forKey:QcmSqLiteAdapter.COL_NB_POINTS];
    [managedObject setValue:qcm.category.id forKey:QcmSqLiteAdapter.COL_ID_CATEGORY];
    [managedObject setValue:[NSNumber numberWithInt:qcm.id_server]forKey:QcmSqLiteAdapter.COL_ID_SERVER];
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
    fetchRequest.entity = [NSEntityDescription entityForName:QcmSqLiteAdapter.ENTITY_QCM
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

-(NSManagedObject*)getByIdServer:(Qcm*)qcm {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    

    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_server = %i",qcm.id_server];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QcmSqLiteAdapter.ENTITY_QCM];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute query
    NSManagedObject* managedObject = [[context executeFetchRequest:request error:nil]objectAtIndex:0];
    
    return managedObject;
    
}

-(void)update:(NSManagedObject*)managedObject withQcm:(Qcm*)qcm {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    //update table
    [managedObject setValue:qcm.libelle forKey:QcmSqLiteAdapter.COL_LIBELLE];
    [managedObject setValue:qcm.datePubli forKey:QcmSqLiteAdapter.COL_DATE_PUBLI];
    [managedObject setValue:qcm.dateFin forKey:QcmSqLiteAdapter.COL_DATE_FIN];
    [managedObject setValue:qcm.nbPoints forKey:QcmSqLiteAdapter.COL_NB_POINTS];
    [managedObject setValue:qcm.category.id forKey:QcmSqLiteAdapter.COL_ID_CATEGORY];
    [managedObject setValue:[NSNumber numberWithInt:qcm.id_server]forKey:QcmSqLiteAdapter.COL_ID_SERVER];
    [appDelegate saveContext];
    
}
-(void)remove:(NSManagedObject*)managedObject {
    
    //DB instance
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context =appDelegate.managedObjectContext;
    
    [context deleteObject:managedObject];
    
}


@end
