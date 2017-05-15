//
//  ViewController.m
//  SuspendedSearchBar
//
//  Created by aliviya on 17/5/15.
//  Copyright © 2017年 jingying. All rights reserved.
//

#import "ViewController.h"
static float headerHeight =200;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIImageView *imageView;
    UIButton *button;
}
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIView *searchView;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    //    self.edgesForExtendedLayout = UIRectEdgeNone;// 推荐使用
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    
}
-(void)setupView{
    
    
    self.tableview.contentInset =UIEdgeInsetsMake(headerHeight,0,0,0);
    [self.view addSubview:self.tableview];
    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -headerHeight, KScreenWidth, headerHeight)];
    
    imageView.image = [UIImage imageNamed:@"Guide-2"];
    
    imageView.contentMode =UIViewContentModeScaleToFill;
    imageView.userInteractionEnabled = YES;
    [self.tableview addSubview:imageView];
    
    
    //    imageView.layer.zPosition = ;//由于imageView上面还会添加一层layer，为了让他一直在layer下面，所以我给他设置了一个zPosition属性，让他一直处在下面。
    float w_search = 250;
    float h_search = 40;
    float w_button = 80;
    
    
    UIView *searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, (KScreenWidth-w_search-w_button)/2, w_search+w_button, h_search)];
    
    searchBar.userInteractionEnabled = YES;
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, h_search)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"上海" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addressButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [searchBar addSubview:button];
    
    UITextField *txtfJihuoma = [[UITextField alloc] initWithFrame:CGRectMake(w_button, 0, w_search, h_search)];
    
    txtfJihuoma.delegate = self;
    txtfJihuoma.borderStyle = UITextBorderStyleNone;
    txtfJihuoma.leftViewMode = UITextFieldViewModeAlways;
    txtfJihuoma.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    txtfJihuoma.backgroundColor = [UIColor colorWithRed:218/255.f green:0/255.f blue:0/255.f alpha:1.f];
    txtfJihuoma.backgroundColor = [UIColor whiteColor];
    txtfJihuoma.returnKeyType = UIReturnKeySearch;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"输入小区名称" attributes:dict];
    [txtfJihuoma setAttributedPlaceholder:attribute];
    
    [txtfJihuoma setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtfJihuoma.textColor = [UIColor whiteColor];
    txtfJihuoma.font = [UIFont systemFontOfSize:14];
    
    UIImageView *imgvSearchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    imgvSearchIcon.image = [UIImage imageNamed:@"search"];
    txtfJihuoma.leftView = imgvSearchIcon;
    
    [searchBar addSubview:txtfJihuoma];
    
    
    //
    [imageView addSubview:searchBar];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(w_search+w_button));
        make.height.equalTo(@(h_search));
        make.centerX.equalTo(imageView.mas_centerX);
        make.bottom.mas_equalTo(imageView.mas_bottom).with.offset(-5);
    }];
    
    
    [self createSearchView];
    
    
}

-(void)createSearchView{
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
    //    self.searchView.backgroundColor = [UIColor blueColor];  //52 151 208
    self.searchView.backgroundColor =  RGBACOLOR(52,151,208,1);
    
    [self.view addSubview:self.searchView];
    
    //    imageView.layer.zPosition = ;//由于imageView上面还会添加一层layer，为了让他一直在layer下面，所以我给他设置了一个zPosition属性，让他一直处在下面。
    float w_search = 250;
    float h_search = 40;
    float w_button = 80;
    
    
    UIView *searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, (KScreenWidth-w_search-w_button)/2, w_search+w_button, h_search)];
    
    searchBar.userInteractionEnabled = YES;
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, h_search)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"上海" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addressButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [searchBar addSubview:button];
    
    UITextField *txtfJihuoma = [[UITextField alloc] initWithFrame:CGRectMake(w_button, 0, w_search, h_search)];
    
    txtfJihuoma.delegate = self;
    txtfJihuoma.borderStyle = UITextBorderStyleNone;
    txtfJihuoma.leftViewMode = UITextFieldViewModeAlways;
    txtfJihuoma.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    txtfJihuoma.backgroundColor = [UIColor colorWithRed:218/255.f green:0/255.f blue:0/255.f alpha:1.f];
    txtfJihuoma.backgroundColor = [UIColor whiteColor];
    txtfJihuoma.returnKeyType = UIReturnKeySearch;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"输入小区名称" attributes:dict];
    [txtfJihuoma setAttributedPlaceholder:attribute];
    
    [txtfJihuoma setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtfJihuoma.textColor = [UIColor whiteColor];
    txtfJihuoma.font = [UIFont systemFontOfSize:14];
    
    UIImageView *imgvSearchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    imgvSearchIcon.image = [UIImage imageNamed:@"search"];
    txtfJihuoma.leftView = imgvSearchIcon;
    
    [searchBar addSubview:txtfJihuoma];
    
    
    //
    [self.searchView addSubview:searchBar];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(w_search+w_button));
        make.height.equalTo(@(h_search));
        make.centerX.equalTo(self.searchView.mas_centerX);
        make.bottom.mas_equalTo(self.searchView.mas_bottom).with.offset(-5);
    }];
    
    self.searchView.hidden = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
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

#pragma mark Tableview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.tableview.contentOffset.y < -headerHeight){//-200等等时候，也就是下拉更多的时候
        
        imageView.frame =CGRectMake(0,0, KScreenWidth+(headerHeight-self.tableview.contentOffset.y),-self.tableview.contentOffset.y);//先修改imageView的Frame，达到图片放大的效果。
        
        imageView.center =CGPointMake(KScreenWidth/2,self.tableview.contentOffset.y/2);//由于修改完Frame会修改中心，所以会产生位置偏差，设置center重新定位
        
        
        
        NSLog(@"==== %@",NSStringFromCGRect(imageView.frame));
        
    }else if(self.tableview.contentOffset.y == -headerHeight){//正好停留在初始化的时候的情况，给他恢复最初状态。
        
        
        
        imageView.frame =CGRectMake(0, -headerHeight,KScreenWidth, headerHeight);
        
    }else if(self.tableview.contentOffset.y > -headerHeight){//当上拉的时候，修改layer背景色的alpha，改变透明度
        
        NSLog(@"self.tableview content offset .y  -%f",self.tableview.contentOffset.y );
        
        if (self.tableview.contentOffset.y > -50){
            self.searchView.hidden = NO;
        }else{
            self.searchView.hidden = YES;
        }
    }
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"HomePageCardCell";
    HomePageCardCell *cell = [HomePageCardCell cellWithTableview:tableView cellIdentify:cellIdentify];
    cell.delegate  =self;
    
    return cell;
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    //    }
    //
    //    cell.textLabel.text = @"456789";
    //    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark textfeild delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //弹出小区选择框
    NSLog(@"弹出小区选择框");
    
    return NO;
}
#pragma mark - event response
-(void)addressButtonClicked:(id)sender{
    NSLog(@"点击地点选择button");
}

#pragma mark HomePageCardCellDelegate delegate
-(void)cardClicked:(int)cardNum{
    NSLog(@" 点击选项卡");
}
#pragma mark Getters -Setters
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
    }
    return _tableview;
}

@end
