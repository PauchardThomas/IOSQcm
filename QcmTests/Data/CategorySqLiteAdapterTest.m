//
//  CategorySqLiteAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "CategorySqLiteAdapter.h"
@interface CategorySqLiteAdapterTest : XCTestCase
@property(strong) NSManagedObjectContext* context;
@property(strong) NSManagedObject* managedObject;
@end

@implementation CategorySqLiteAdapterTest
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
    self.managedObject= [NSEntityDescription insertNewObjectForEntityForName:CategorySqLiteAdapter.ENTITY_CATEGORY inManagedObjectContext:self.context];
    
    //Insert table
    [self.managedObject setValue:CategorySqLiteAdapterTest.LIBELLE forKey:CategorySqLiteAdapter.COL_LIBELLE];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:CategorySqLiteAdapter.COL_ID_SERVER];
    NSError* error = nil;
    [self.context save:&error];
    XCTAssertNotNil(self.managedObject);
}

-(void)testGetAll{
    NSArray* categories = [NSArray new];
    
    // Request Get DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table from request
    fetchRequest.entity = [NSEntityDescription entityForName:CategorySqLiteAdapter.ENTITY_CATEGORY
                                      inManagedObjectContext:self.context];
    
    //get all categories db object
    categories = [self.context executeFetchRequest:fetchRequest error:nil];
    
    XCTAssertNotNil(categories);
    
}
-(void)testGetByIdServer {

    
    //creat filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_server = %d",2];
    
    //Create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:CategorySqLiteAdapter.ENTITY_CATEGORY];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute query
    NSManagedObject* managedObject = nil;
    
    @try {
        managedObject =[[self.context executeFetchRequest:request error:nil]objectAtIndex:0];
        XCTAssertEqual(1,2);
    }@catch(NSException* e) {
        NSLog(@"%@",e);
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
