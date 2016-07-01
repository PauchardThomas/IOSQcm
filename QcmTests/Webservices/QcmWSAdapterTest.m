//
//  QcmWSAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworking.h"
#import "QcmWSAdapter.h"

@interface QcmWSAdapterTest : XCTestCase
@property(nonatomic) QcmWSAdapter* qcmWSAdapter;
@end

@implementation QcmWSAdapterTest

- (void)setUp {
    [super setUp];
    QcmWSAdapter* qcmWSAdapter  =[QcmWSAdapter new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testgetQcms {

    // Create expectation
    XCTestExpectation* expectation = [self expectationWithDescription:@"getQcms"];
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = [NSString stringWithFormat:@"%@/%d/qcm",QcmWSAdapter.BASE_URL,2];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse* response = (NSHTTPURLResponse*) task.response;
        NSInteger statusCode = [response statusCode];
        XCTAssertEqual(200,statusCode);
        [expectation fulfill];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@",error);
        NSHTTPURLResponse* response = (NSHTTPURLResponse*) task.response;
        NSInteger statusCode = [response statusCode];
        XCTAssertEqual(500,statusCode);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void) testgetQcm{
    
    // Create expectation
    XCTestExpectation* expectation = [self expectationWithDescription:@"getQcm"];
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = [NSString stringWithFormat:@"%@/%d",QcmWSAdapter.BASE_URL2,4];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse* response = (NSHTTPURLResponse*) task.response;
        NSInteger statusCode = [response statusCode];
        XCTAssertEqual(200,statusCode);
        [expectation fulfill];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@",error);
        NSHTTPURLResponse* response = (NSHTTPURLResponse*) task.response;
        NSInteger statusCode = [response statusCode];
        XCTAssertEqual(500,statusCode);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
