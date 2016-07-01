//
//  ProposalUserSqLiteAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "ProposalUserSqLiteAdapter.h"
@interface ProposalUserSqLiteAdapterTest : XCTestCase
@property(strong) NSManagedObjectContext* context;
@property(strong) NSManagedObject* managedObject;
@end

@implementation ProposalUserSqLiteAdapterTest

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
    self.managedObject= [NSEntityDescription insertNewObjectForEntityForName:ProposalUserSqLiteAdapter.ENTITY_PROPOSAL_USER inManagedObjectContext:self.context];
    
    //Insert table
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:ProposalUserSqLiteAdapter.COL_USER_ID];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:ProposalUserSqLiteAdapter.COL_QCM_ID];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:ProposalUserSqLiteAdapter.COL_QUESTION_ID];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:ProposalUserSqLiteAdapter.COL_PROPOSAL_ID];
    
    [self.context save:nil];
    XCTAssertNotNil(self.managedObject);
}
-(void)testGetByUserQuestion{
    // create filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"user_id == %d AND proposal_id == %d",99,99];
    
    //create query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:ProposalUserSqLiteAdapter.ENTITY_PROPOSAL_USER];
    
    //set filter to query
    //request.predicate = predicate;
    [request setPredicate:predicate];
    
    //get by id server
    NSManagedObject* managedObject = nil;
    @try {
        managedObject =[[self.context executeFetchRequest:request error:nil]objectAtIndex:0];
        XCTAssertEqual(1,2);
    }@catch(NSException* e) {
        NSLog(@"execption : %@",e);
        XCTAssertEqual(1,1);
    }
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
