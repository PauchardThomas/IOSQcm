//
//  QuestionSqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
@interface QuestionSqLiteAdapter : NSObject

// Question entity
+(NSString*) ENTITY_QUESTION;
// Question libelle
+(NSString*) COL_LIBELLE;
// Question points
+(NSString*) COL_POINTS;
// Question id qcm
+(NSString*) COL_ID_QCM;
// Question id server
+(NSString*) COL_ID_SERVER;

// Insert question
-(NSManagedObject*)insert:(Question*)question;
// Get all question
-(NSArray*) getAll;
// Get question by id
-(NSManagedObject*)getById:(NSManagedObject *)question;
// Get questions by id server
-(NSManagedObject*)getByIdServer:(Question*)question;
// Get questions by qcm
-(NSArray*)getByQcm:(Qcm*)qcm;
// Update question
-(void)update:(NSManagedObject*)managedObject withQuestion:(Question*)question;
// remove question
-(void)remove:(NSManagedObject*)managedObject;

@end
