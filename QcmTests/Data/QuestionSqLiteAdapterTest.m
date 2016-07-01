//
//  QuestionSqLiteAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "QuestionSqLiteAdapter.h"
@interface QuestionSqLiteAdapterTest : XCTestCase
@property(strong) NSManagedObjectContext* context;
@property(strong) NSManagedObject* managedObject;
@end

@implementation QuestionSqLiteAdapterTest
+(NSString*) LIBELLE {return @"libelleTest";}
- (void)setUp {
    [super setUp];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Qcm" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    XCTAssertTrue([psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    self.context = [[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator = psc;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInsert {
    //get table
    self.managedObject= [NSEntityDescription insertNewObjectForEntityForName:QuestionSqLiteAdapter.ENTITY_QUESTION inManagedObjectContext:self.context];
    
    //Insert table
    [self.managedObject setValue:QuestionSqLiteAdapterTest.LIBELLE forKey:QuestionSqLiteAdapter.COL_LIBELLE];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:QuestionSqLiteAdapter.COL_ID_QCM];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:QuestionSqLiteAdapter.COL_ID_SERVER];
    [self.context save:nil];
    
    XCTAssertNotNil(self.managedObject);
}
-(void)testGetByQcm {
    
    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"qcm_id = %d",99];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QuestionSqLiteAdapter.ENTITY_QUESTION];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute query
    NSArray* questions = [self.context executeFetchRequest:request error:nil];
    
    XCTAssertNotNil(questions);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
