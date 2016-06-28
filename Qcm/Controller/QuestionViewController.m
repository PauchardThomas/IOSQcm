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
#import "ProposalUserSqLiteAdapter.h"
#import "ProposalUser.h"
@interface QuestionViewController ()

@end

@implementation QuestionViewController
@synthesize lbQuestion,lbR1,lbR2,lbR3,lbR4,swR1,swR2,swR3,swR4,qcm,user;
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
    ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
    for(Proposal* proposal in maQuestion.proposals) {
        switch (j) {
            case 1:
                swR1.tag = [proposal.id_server integerValue];
                NSLog(@"proposal switch 1 id server : %ld",swR1.tag);
                lbR1.text = proposal.libelle;
                if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR1.tag]] != nil) {
                    [swR1 setOn:true];
                }else {
                    [swR1 setOn:false];
                }
                break;
            case 2:
                swR2.tag = [proposal.id_server integerValue];
                NSLog(@"proposal switch 2 id server : %ld",swR2.tag);
                lbR2.text = proposal.libelle;
                if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR2.tag]] != nil) {
                    [swR2 setOn:true];
                }else {
                    [swR2 setOn:false];
                }
                break;
            case 3 :
                swR3.tag = [proposal.id_server integerValue];
                NSLog(@"proposal switch 3 id server : %ld",swR3.tag);
                lbR3.text = proposal.libelle;
                if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR3.tag]] != nil) {
                    [swR3 setOn:true];
                }else {
                    [swR3 setOn:false];
                }
                break;
            case 4 :
                swR4.tag = [proposal.id_server integerValue];
                NSLog(@"proposal switch 4 id server : %ld",swR4.tag);
                lbR4.text = proposal.libelle;
                if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR4.tag]] != nil) {
                    [swR4 setOn:true];
                }else {
                    [swR4 setOn:false];
                }
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
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR1.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter insert:proposalUser];
        
        
    } else {
        [self.view makeToast:@"No selected"];
        
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR1.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter remove:proposalUser];
    }
}

- (IBAction)sw2:(id)sender {
    if ([sender isOn]) {
        [self.view makeToast:@"Selected, id server :"];
        NSLog(@"-------");
        NSLog(@"id serveur : %ld",swR2.tag);
        NSLog(@"-------");
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR2.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter insert:proposalUser];
    } else {
        [self.view makeToast:@"No selected"];
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR2.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter remove:proposalUser];
    }
}
- (IBAction)sw3:(id)sender {
    if ([sender isOn]) {
        [self.view makeToast:@"Selected, id server :"];
        NSLog(@"-------");
        NSLog(@"id serveur : %ld",swR3.tag);
        NSLog(@"-------");
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR3.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter insert:proposalUser];
    } else {
        [self.view makeToast:@"No selected"];
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR3.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter remove:proposalUser];
    }
}
- (IBAction)sw4:(id)sender {
    if ([sender isOn]) {
        [self.view makeToast:@"Selected, id server :"];
        NSLog(@"-------");
        NSLog(@"id serveur : %ld",swR4.tag);
        NSLog(@"-------");
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR4.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter insert:proposalUser];
    } else {
        [self.view makeToast:@"No selected"];
        ProposalUser* proposalUser = [ProposalUser new];
        proposalUser.user_id = user.id_server;
        proposalUser.qcm_id = qcm.id_server;
        proposalUser.question_id = [[lesQuestions objectForKey:i] id_server];
        proposalUser.proposal_id = [NSNumber numberWithInt:(int)swR4.tag];
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        [proposalUserSqLiteAdapter remove:proposalUser];
    }
}

- (IBAction)previous:(id)sender {
    if(counter>1){
        counter--;
        i = [NSNumber numberWithInt:counter];
        Question* question = [lesQuestions objectForKey:i];
        lbQuestion.text = question.libelle;
        int j =1;
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        for(Proposal* proposal in question.proposals) {
            switch (j) {
                case 1:
                    swR1.tag = [proposal.id_server integerValue];
                    lbR1.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR1.tag]] != nil) {
                        [swR1 setOn:true];
                    }else {
                        [swR1 setOn:false];
                    }
                    break;
                case 2:
                    swR2.tag = [proposal.id_server integerValue];
                    lbR2.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR2.tag]] != nil) {
                        [swR2 setOn:true];
                    }else {
                        [swR2 setOn:false];
                    }
                    break;
                case 3 :
                    swR3.tag = [proposal.id_server integerValue];
                    lbR3.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR3.tag]] != nil) {
                        [swR3 setOn:true];
                    }else {
                        [swR3 setOn:false];
                    }
                    break;
                case 4 :
                    swR4.tag = [proposal.id_server integerValue];
                    lbR4.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR4.tag]] != nil) {
                        [swR4 setOn:true];
                    }else {
                        [swR4 setOn:false];
                    }
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
        [self setTitle:@"Suivant"];
        counter++;
        i = [NSNumber numberWithInt:counter];
        Question* question = [lesQuestions objectForKey:i];
        lbQuestion.text = question.libelle;
        int j =1;
        ProposalUserSqLiteAdapter* proposalUserSqLiteAdapter = [ProposalUserSqLiteAdapter new];
        for(Proposal* proposal in question.proposals) {
            switch (j) {
                case 1:
                    swR1.tag = [proposal.id_server integerValue];
                    lbR1.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR1.tag]] != nil) {
                        [swR1 setOn:true];
                    }else {
                        [swR1 setOn:false];
                    }
                    break;
                case 2:
                    swR2.tag = [proposal.id_server integerValue];
                    lbR2.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR2.tag]] != nil) {
                        [swR2 setOn:true];
                    }else {
                        [swR2 setOn:false];
                    }
                    break;
                case 3 :
                    swR3.tag = [proposal.id_server integerValue];
                    lbR3.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR3.tag]] != nil) {
                        [swR3 setOn:true];
                    }else {
                        [swR3 setOn:false];
                    }
                    break;
                case 4 :
                    swR4.tag = [proposal.id_server integerValue];
                    lbR4.text = proposal.libelle;
                    if([proposalUserSqLiteAdapter getBy:user.id_server :[NSNumber numberWithInt:(int)swR4.tag]] != nil) {
                        [swR4 setOn:true];
                    }else {
                        [swR4 setOn:false];
                    }
                    break;
                default:
                    break;
            }
            j++;
        }
    }else {
        [self.view makeToast:@"On est a la derniere question"];
        [self setTitle:@"Terminer"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
            NSLog(@"ok");
        }];
        [alertController addAction:actionOk];
        UIAlertAction *actionBack = [UIAlertAction actionWithTitle:@"Retour" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionBack];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
