//
//  UserSqLiteAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "UserSqLiteAdapter.h"
#import "User.h"
@interface UserSqLiteAdapterTest : XCTestCase
@property(strong) NSManagedObjectContext* context;
@property(strong) NSManagedObject* managedObject;
@end

@implementation UserSqLiteAdapterTest
+(NSString*) USERNAME {return @"userNameTest";}
+(NSString*) PASSWORD {return @"passwordTest";}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
   /* static NSManagedObjectModel *model = nil;
    if (!model) {
        model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    }
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
    NSAssert(store, @"Should have a store by now");
    
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    moc.persistentStoreCoordinator = psc;
    self.context = moc;*/
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Qcm" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    XCTAssertTrue([psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    self.context = [[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator = psc;
}

- (void)testaInsert {
    NSError* error = nil;
    //get table
    self.managedObject= [NSEntityDescription insertNewObjectForEntityForName:UserSqLiteAdapter.ENTITY_USER inManagedObjectContext:self.context];
    
    //Insert table
    [self.managedObject setValue:UserSqLiteAdapterTest.USERNAME forKey:UserSqLiteAdapter.COL_USERNAME];
    [self.managedObject setValue:UserSqLiteAdapterTest.PASSWORD forKey:UserSqLiteAdapter.COL_PASSWORD];
    [self.managedObject setValue:[NSNumber numberWithInteger:99] forKey:UserSqLiteAdapter.COL_ID_SERVER];
    [self.context save:&error];
    XCTAssertNotNil(self.managedObject);
}
-(void)testgetByIdServer{
    
    // create filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id_server = %d",99];
    
    //create query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:UserSqLiteAdapter.ENTITY_USER];
    
    //set filter to query
    request.predicate = predicate;
    
    //get by id server
    @try {
        self.managedObject =[[self.context executeFetchRequest:request error:nil]objectAtIndex:0];
        XCTAssertEqual(1,2);
    }@catch(NSException* e) {
        XCTAssertEqual(1,1);
    }
    
    
    
}

-(void)testGetByUsernamePassword{

    
    // create filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"username = %@ AND password = %@ ",UserSqLiteAdapterTest.USERNAME,UserSqLiteAdapterTest.PASSWORD];
    
    //create query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:UserSqLiteAdapter.ENTITY_USER];
    
    //set filter to query
    request.predicate = predicate;
    
    //get by id server
    
    @try {
        self.managedObject =[[self.context executeFetchRequest:request error:nil]objectAtIndex:0];
        XCTAssertEqual(1,2);
    }@catch(NSException* e) {
        XCTAssertEqual(1,1);
    }
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
