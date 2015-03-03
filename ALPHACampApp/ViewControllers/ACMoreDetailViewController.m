//
//  ACMoreDetailViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/3/3.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "ACMoreDetailViewController.h"
#import "User.h"

@interface ACMoreDetailViewController (){
    int arrayCount;
}

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *staffArray;
@property (strong, nonatomic) NSArray *teacherArray;
@property (strong, nonatomic) NSArray *alumniArray;
@property (strong, nonatomic) NSDictionary *userDataDict;


@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ACMoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up staffs Array
    User * sBernard =[User initWithfirstName:@"Bernard" lastName:@"Chan"];
    sBernard.intro = @"TMI 駐場創業家，曾任 Yahoo！亞太區廣告業務總監。出生香港、麻省理工學院 Sloan 商學院 MBA 畢業，芝加哥 Ruby on Rails 課程研習、在美國，北京，香港有多次 Startup 經驗";
    
    User * sTim =[User initWithfirstName:@"Tim" lastName:@"Du"];
    sTim.intro =@"清大物理系唸完換台大國企所，熱愛棒球，喜歡喝咖啡、看星星、挑戰新事物，就算買不起 Google Glass 也要想辦法跟別人借來玩一玩。喜歡的一句話是：「人生就像騎腳踏車，為了保持平衡，必須不斷前進。」";
    
    User *sAriel = [User initWithfirstName:@"Ariel" lastName:@"Chen"];
    sAriel.intro =@"政大哲學系、中正心理所畢業。在中國大陸闖蕩三年。認為教育就是從人出發的一種用心交流，希望回歸教育，凝聚最真摯的正向能量，協助講師找到最可發揮的舞台，培育學員找到新的方向";
    
    User *sEvelyn =[User initWithfirstName:@"Evelyn" lastName:@"Chang"];
    sEvelyn.intro =@"卡內基美隆大學藝術管理碩士，從戲劇、藝術管理到數位行銷，不變的是對這個世界的好奇心與對生活的熱情。熱愛行銷與學習，持續關注創業、社群與網路發展。努力讓更多人知道 ALPHA Camp 的好，希望這世界因為自己的存在而美好一點點";
    
    User *sihower =[User initWithfirstName:@"iHower" lastName:@"Chang"];
    sihower.intro =@"Ruby on Rails 實戰聖經作者，前 Faria Systems CTO，多次 COSCUP、OSDC.TW、台灣與中國RubyConf、日本 RubyKaigi 大會講者";
    
    User *sBenson =[User initWithfirstName:@"Benson" lastName:@"Sun"];
    sBenson.intro=@"政大財政系，在 Startup 圈闖蕩的小朋友，從大四開始自學 Web Development ，是 Rails 的初學者 ，立志成為行銷和技術兼備的人才，目前在 ALPHA Camp 愉快的玩耍中";
    
    //add Objects into Array with Literal Syntax
    self.staffArray =@[sBernard,sTim,sAriel,sEvelyn,sihower,sBenson];
    self.teacherArray =@[sBernard];
    self.alumniArray =@[sBernard];
    
    //add objects into Dictionary
    
    self.userDataDict =@{@"staff" : self.staffArray,
                         @"teacher" : self.teacherArray,
                         @"alumni" : self.alumniArray
                         };
    
    //set up next Button
    [self.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    arrayCount =0;
}

- (void)nextButtonPressed: (id)sender{
    
    arrayCount ++;
    if (arrayCount >5) {
        arrayCount =0;
        self.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[self.staffArray[arrayCount] firstName],[self.staffArray[arrayCount] lastName] ];
        self.introLabel.text=[NSString stringWithFormat:@"%@", [self.staffArray[arrayCount] intro]];
    }else{
        self.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[self.staffArray[arrayCount] firstName],[self.staffArray[arrayCount] lastName] ];
        self.introLabel.text=[NSString stringWithFormat:@"%@", [self.staffArray[arrayCount] intro]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControlSwitch:(id)sender {
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            
            self.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[self.staffArray[arrayCount] firstName],[self.staffArray[arrayCount] lastName] ];
            self.introLabel.text=[NSString stringWithFormat:@"%@", [self.staffArray[1] intro]];
           
            break;
        case 1:
            self.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[self.staffArray[arrayCount] firstName],[self.staffArray[arrayCount] lastName] ];
            self.introLabel.text=[NSString stringWithFormat:@"%@", [self.staffArray[4] intro]];
            
            break;
        case 2:
          self.nameLabel.text=@"Abby Hsu";
            
            break;
        default:
            break;
    }
    
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
