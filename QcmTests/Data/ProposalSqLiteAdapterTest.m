//
//  ProposalSqLiteAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "ProposalSqLiteAdapter.h"
@interface ProposalSqLiteAdapterTest : XCTestCase
@property(strong) NSManagedObjectContext* context;
@property(strong) NSManagedObject* managedObject;
@end

@implementation ProposalSqLiteAdapterTest
+(NSString*) LIBELLE {return @"libelleTest";}
- (void)setUp {
    
    [super setUp];
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
    NSManagedObject* managedObject= [NSEntityDescription insertNewObjectForEntityForName:ProposalSqLiteAdapter.ENTITY_PROPOSAL inManagedObjectContext:self.context];
    
    //Insert table
    [managedObject setValue:ProposalSqLiteAdapterTest.LIBELLE forKey:ProposalSqLiteAdapter.COL_LIBELLE];
    [managedObject setValue:[NSNumber numberWithInteger:99] forKey:ProposalSqLiteAdapter.COL_QUESTION];
    [managedObject setValue:[NSNumber numberWithInteger:99] forKey:ProposalSqLiteAdapter.COL_ID_SERVER];
    
    [self.context save:nil];
    XCTAssertNotNil(managedObject);
    
}
-(void)testGetByQuestion {
    
    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_question = %d",99];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:ProposalSqLiteAdapter.ENTITY_PROPOSAL];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute query
    NSArray* proposals = [self.context executeFetchRequest:request error:nil];
    
    XCTAssertNotNil(proposals);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
