//
//  CategorySqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@interface CategorySqLiteAdapter : NSObject

+(NSString*) ENTITY_CATEGORY;
+(NSString*) COL_LIBELLE;
+(NSString*) COL_ID_SERVER;

-(void)insert:(EntityCategory*)category;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)category;
-(NSManagedObject*)getByIdServer:(EntityCategory*)category;
-(void)update:(NSManagedObject*)managedObject withCategory:(EntityCategory*)category;
-(void)remove:(NSManagedObject*)managedObject;


@end
