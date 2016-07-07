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

// Category entity
+(NSString*) ENTITY_CATEGORY;
// Category libelle
+(NSString*) COL_LIBELLE;
// Category id server
+(NSString*) COL_ID_SERVER;

// Insert category
-(void)insert:(EntityCategory*)category;
// Get all categories
-(NSArray*) getAll;
// Get category by id
-(NSManagedObject*)getById:(NSManagedObject *)category;
// Get category by id server
-(NSManagedObject*)getByIdServer:(EntityCategory*)category;
// Update category
-(void)update:(NSManagedObject*)managedObject withCategory:(EntityCategory*)category;
// Delete category
-(void)remove:(NSManagedObject*)managedObject;


@end
