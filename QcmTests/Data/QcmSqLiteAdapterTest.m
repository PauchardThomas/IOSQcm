//
//  QcmSqLiteAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QcmSqLiteAdapter.h"
#import "AppDelegate.h"
@interface QcmSqLiteAdapterTest : XCTestCase
@property(strong) NSManagedObjectContext* context;
@property(strong) NSManagedObject* managedObject;
@end

@implementation QcmSqLiteAdapterTest
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
    self.managedObject= [NSEntityDescription insertNewObjectForEntityForName:QcmSqLiteAdapter.ENTITY_QCM inManagedObjectContext:self.context];
    
    //Insert table
    [self.managedObject setValue:QcmSqLiteAdapterTest.LIBELLE forKey:QcmSqLiteAdapter.COL_LIBELLE];
    [self.managedObject setValue:[NSNumber numberWithInteger:20] forKey:QcmSqLiteAdapter.COL_NB_POINTS];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:QcmSqLiteAdapter.COL_ID_CATEGORY];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:QcmSqLiteAdapter.COL_ID_SERVER];
    NSError* error = nil;
    [self.context save:&error];
    XCTAssertNotNil(self.managedObject);
}
-(void)testGetAll{

    NSArray* qcms = [NSArray new];

    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:QcmSqLiteAdapter.ENTITY_QCM inManagedObjectContext:self.context];
    
    //get all cities db object
    qcms = [self.context executeFetchRequest:fetchRequest error:nil];
    
    XCTAssertNotNil(qcms);
}
-(void)testGetByIdServer {
    
    
    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_server = %d",99];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QcmSqLiteAdapter.ENTITY_QCM];
    
    //set the filter on the query
    request.predicate = predicate;
    NSManagedObject* managedObject = nil;
    @try {
        managedObject = [[self.context executeFetchRequest:request error:nil]objectAtIndex:0];
        XCTAssertEqual(1,2);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
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
