//
//  QuestionViewController.m
//  Qcm
//
//  Created by etudiant on 18/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionViewController.h"
#import "QcmSqLiteAdapter.h"
#import "UIView+Toast.h"
@interface QuestionViewController ()

@end

@implementation QuestionViewController
@synthesize lbQuestion,lbR1,lbR2,lbR3,lbR4,swR1,swR2,swR3,swR4,qcm;
NSMutableDictionary* lesQuestions;
NSNumber* i;
int counter;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Qcm* q = (Qcm*)qcm;

    lesQuestions = [NSMutableDictionary new];
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
    counter = 1;
    i = [NSNumber numberWithInt:counter];
    
    Question* maQuestion = [lesQuestions objectForKey:i];
    
    lbQuestion.text = maQuestion.libelle;
    int j =1;
    for(Proposal* proposal in maQuestion.proposals) {
        switch (j) {
            case 1:
                swR1.tag = [proposal.id_server integerValue];
                lbR1.text = proposal.libelle;
                break;
            case 2:
                swR2.tag = [proposal.id_server integerValue];
                lbR2.text = proposal.libelle;
                break;
            case 3 :
                swR3.tag = [proposal.id_server integerValue];
                lbR3.text = proposal.libelle;
                break;
            case 4 :
                swR4.tag = [proposal.id_server integerValue];
                lbR4.text = proposal.libelle;
                break;
            default:
                break;
        }
        j++;
    }
    
    
    
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


- (IBAction)sw1:(id)sender {
    if ([sender isOn]) {
        [self.view makeToast:@"Selected, id server :"];
        NSLog(@"-------");
        NSLog(@"id serveur : %ld",swR1.tag);
        NSLog(@"-------");
    } else {
        [self.view makeToast:@"No selected"];
    }
}

- (IBAction)sw2:(id)sender {
    if ([sender isOn]) {
        [self.view makeToast:@"Selected, id server :"];
        NSLog(@"-------");
        NSLog(@"id serveur : %ld",swR2.tag);
        NSLog(@"-------");
    } else {
        [self.view makeToast:@"No selected"];
    }
}
- (IBAction)sw3:(id)sender {
    if ([sender isOn]) {
        [self.view makeToast:@"Selected, id server :"];
        NSLog(@"-------");
        NSLog(@"id serveur : %ld",swR3.tag);
        NSLog(@"-------");
    } else {
        [self.view makeToast:@"No selected"];
    }
}
- (IBAction)sw4:(id)sender {
    if ([sender isOn]) {
        [self.view makeToast:@"Selected, id server :"];
        NSLog(@"-------");
        NSLog(@"id serveur : %ld",swR4.tag);
        NSLog(@"-------");
    } else {
        [self.view makeToast:@"No selected"];
    }
}

- (IBAction)previous:(id)sender {
    if(counter>1){
        counter--;
        i = [NSNumber numberWithInt:counter];
        Question* question = [lesQuestions objectForKey:i];
        lbQuestion.text = question.libelle;
        int j =1;
        for(Proposal* proposal in question.proposals) {
            switch (j) {
                case 1:
                    swR1.tag = [proposal.id_server integerValue];
                    lbR1.text = proposal.libelle;
                    break;
                case 2:
                    swR2.tag = [proposal.id_server integerValue];
                    lbR2.text = proposal.libelle;
                    break;
                case 3 :
                    swR3.tag = [proposal.id_server integerValue];
                    lbR3.text = proposal.libelle;
                    break;
                case 4 :
                    swR4.tag = [proposal.id_server integerValue];
                    lbR4.text = proposal.libelle;
                    break;
                default:
                    break;
            }
            j++;
        }
    }else {
        [self.view makeToast:@"On est a la 1ere question"];
    }
}

- (IBAction)next:(id)sender {
    if(counter < [lesQuestions count]){
        counter++;
        i = [NSNumber numberWithInt:counter];
        Question* question = [lesQuestions objectForKey:i];
        lbQuestion.text = question.libelle;
        int j =1;
        for(Proposal* proposal in question.proposals) {
            switch (j) {
                case 1:
                    swR1.tag = [proposal.id_server integerValue];
                    lbR1.text = proposal.libelle;
                    break;
                case 2:
                    swR2.tag = [proposal.id_server integerValue];
                    lbR2.text = proposal.libelle;
                    break;
                case 3 :
                    swR3.tag = [proposal.id_server integerValue];
                    lbR3.text = proposal.libelle;
                    break;
                case 4 :
                    swR4.tag = [proposal.id_server integerValue];
                    lbR4.text = proposal.libelle;
                    break;
                default:
                    break;
            }
            j++;
        }
    }else {
        [self.view makeToast:@"On est a la derniere question"];
    }
}

@end
