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

+(NSString*) ENTITY_QUESTION;
+(NSString*) COL_LIBELLE;
+(NSString*) COL_POINTS;
+(NSString*) COL_ID_QCM;
+(NSString*) COL_ID_SERVER;

-(NSManagedObject*)insert:(Question*)question;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)question;
-(NSManagedObject*)getByIdServer:(Question*)question;
-(NSArray*)getByQcm:(Qcm*)qcm;
-(void)update:(NSManagedObject*)managedObject withQuestion:(Question*)question;
-(void)remove:(NSManagedObject*)managedObject;

@end
