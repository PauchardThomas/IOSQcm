//
//  QuestionViewController.m
//  Qcm
//
//  Created by etudiant on 18/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionViewController.h"
#import "QcmSqLiteAdapter.h"
@interface QuestionViewController ()

@end

@implementation QuestionViewController
@synthesize lbQuestion,lbR1,lbR2,lbR3,lbR4,swR1,swR2,swR3,swR4,qcm;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Qcm* q = (Qcm*)qcm;

    NSMutableDictionary* lesQuestions = [NSMutableDictionary new];
    int iter = 1;
    NSNumber *compteur = [NSNumber numberWithInt:iter];
    QuestionSqLiteAdapter* questionSqLiteAdapter = [QuestionSqLiteAdapter new];
    NSArray* questions = [questionSqLiteAdapter getByQcm:q];
    NSMutableArray* qq = [NSMutableArray new];
    
    ProposalSqLiteAdapter* proposaSqLiteAdapter = [ProposalSqLiteAdapter new];
    
    for(Question *question in questions) {
        Question* quest = [Question new];
        quest.id_server = question.id_server;
        quest.libelle = question.libelle;
        quest.points = question.points;
        quest.qcm = q;
        NSArray* proposals =[proposaSqLiteAdapter getByQuestion:question];
        quest.proposals =proposals;
        compteur = [NSNumber numberWithInt:iter];
        iter++;
        [lesQuestions setObject:quest forKey:compteur];
        [qq addObject:quest];
    }
    NSArray* test = [[NSArray alloc]initWithArray:qq];
    
    Qcm* myqcm = [Qcm new];
    myqcm.libelle = @"libelle";
    myqcm.id_server = q.id_server;
    myqcm.category_id = q.category_id;
    myqcm.nbPoints = q.nbPoints;
    myqcm.questions = test;
    NSLog(@"Voila..");
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
